import subprocess
import re
import os
import sys

def run_command(cmd):
    try:
        # Run with shell=True
        output = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)
        return output.decode('utf-8').strip()
    except subprocess.CalledProcessError as e:
        return ""

def get_osd_info():
    # Map VG to PV
    vg_to_pv = {}
    # pvs requires sudo
    pvs_out = run_command("sudo pvs -o vg_name,pv_name --noheadings --separator '|'")
    for line in pvs_out.splitlines():
        parts = line.strip().split('|')
        if len(parts) == 2:
            vg = parts[0].strip()
            pv = parts[1].strip()
            if vg:
                vg_to_pv[vg] = pv

    # Map OSD ID to VG
    osd_to_vg = {}
    # lvdisplay requires sudo
    lv_out = run_command("sudo lvdisplay -C -o vg_name,lv_tags --noheadings --separator '|'")
    for line in lv_out.splitlines():
        parts = line.strip().split('|')
        if len(parts) >= 2:
            vg = parts[0].strip()
            tags = parts[1].strip()
            if "ceph.type=block" in tags and "ceph.osd_id=" in tags:
                # Extract OSD ID
                match = re.search(r'ceph.osd_id=(\d+)', tags)
                if match:
                    osd_id = match.group(1)
                    osd_to_vg[osd_id] = vg

    return osd_to_vg, vg_to_pv

def get_disk_numa(pv_path):
    # pv_path e.g. /dev/sda or /dev/nvme0n1p1
    dev_name = os.path.basename(pv_path)
    
    # Start with the sysfs path for the block device
    sys_path = f"/sys/class/block/{dev_name}"
    if not os.path.exists(sys_path):
        # Handle partition case (e.g. nvme0n1p1 -> nvme0n1)
        # This is a simple heuristic
        if "nvme" in dev_name and "p" in dev_name:
             parent = re.sub(r'p\d+$', '', dev_name)
             sys_path = f"/sys/class/block/{parent}"
        elif re.search(r'\d+$', dev_name):
             parent = re.sub(r'\d+$', '', dev_name)
             sys_path = f"/sys/class/block/{parent}"
    
    if os.path.exists(sys_path):
        # Resolve symlink to get real path in /sys/devices/...
        try:
            real_path = os.path.realpath(sys_path)
        except:
            return "?"
            
        # Traverse up looking for numa_node
        curr = real_path
        while len(curr) > 1:
            node_path = os.path.join(curr, "numa_node")
            if os.path.exists(node_path):
                try:
                    with open(node_path, 'r') as f:
                        val = f.read().strip()
                        # -1 implies no specific node (UMA or unknown)
                        if val == "-1":
                            return "ANY"
                        return val
                except:
                    pass
            
            # Move up
            parent = os.path.dirname(curr)
            if parent == curr:
                break
            curr = parent
            
            # Stop if we left /sys/devices (safety)
            if not curr.startswith("/sys/devices"):
                break
                
    return "?"

def get_pid_affinity(osd_id):
    # Find PID
    # Search for "ceph-osd --id <ID>" or "id <ID>"
    # We need to be careful to match exact ID.
    # ps output: ... ceph-osd ... --id 31 ...
    # grep pattern: " --id <ID> "
    ps_out = run_command(f"ps -eo pid,args | grep ' --id {osd_id} ' | grep -v grep")
    
    pid = None
    for line in ps_out.splitlines():
        parts = line.strip().split()
        if parts:
            pid = parts[0]
            break
            
    if not pid:
        return None, None

    # Get affinity
    # taskset -cp <pid> output: "pid 1234's current affinity list: 0-15"
    ts_out = run_command(f"sudo taskset -cp {pid}")
    affinity = "?"
    if "current affinity list:" in ts_out:
        affinity = ts_out.split("current affinity list:")[1].strip()
    
    return pid, affinity

def main():
    # Get Hostname
    hostname = run_command("hostname")
    print(f"Report for Node: {hostname}")
    print(f"{'OSD_ID':<8} {'PV_DEVICE':<20} {'DISK_NUMA':<10} {'PID':<8} {'CPU_AFFINITY':<20}")
    print("-" * 70)
    
    osd_to_vg, vg_to_pv = get_osd_info()
    
    sorted_ids = sorted(osd_to_vg.keys(), key=lambda x: int(x))
    
    for osd_id in sorted_ids:
        vg = osd_to_vg[osd_id]
        pv = vg_to_pv.get(vg, "?")
        
        disk_numa = "?"
        if pv != "?":
            disk_numa = get_disk_numa(pv)
            
        pid, affinity = get_pid_affinity(osd_id)
        
        if not pid:
            pid = "MISSING"
            affinity = "?"
            
        print(f"{osd_id:<8} {pv:<20} {disk_numa:<10} {pid:<8} {affinity:<20}")

if __name__ == "__main__":
    main()
