#!/bin/bash
set -euo pipefail

bash ssh_fio.sh /dev/rbd1 ds3.fio intel-4610-nvme
