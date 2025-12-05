#!/bin/bash
set -euo pipefail

bash ssh_fio.sh /dev/rbd0 test.fio intel-900p-hdd

