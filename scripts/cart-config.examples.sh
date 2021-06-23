GCLOUD_PROJECT=project
GCLOUD_ZONE=us-central1-a
GCLOUD_VMNAME=cloudvm
GCLPUD_USERNAME=$USER

GCLOUD_FLAGS=()
GCLOUD_FLAGS+=("--project ${GCLOUD_PROJECT}")
GCLOUD_FLAGS+=("--zone ${GCLOUD_ZONE}")

# Usage:
# SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" >/dev/null 2>&1 && pwd  )"
# source $SCRIPT_SRC_DIR/cart-config.sh
# command1 "${GCLOUD_FLAGS[@]}" command2 "${GCOUD_USERNAME}@${GCLOUD_VMNAME}"
