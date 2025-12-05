#!/bin/bash
set -euo pipefail

bash ssh_fio.sh /dev/rbd0 test-prepare.fio intel-900p-hdd
