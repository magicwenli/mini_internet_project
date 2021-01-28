#!/bin/bash
#
# build all images and upload to the docker hub

set -o errexit
set -o pipefail
set -o nounset

isula-build --tag=d_router docker_images/router/
isula-build --tag=d_ixp docker_images/ixp/
isula-build --tag=d_host docker_images/host/
isula-build --tag=d_ssh docker_images/ssh/
isula-build --tag=d_measurement docker_images/measurement/
isula-build --tag=d_dns docker_images/dns/
isula-build --tag=d_switch docker_images/switch/
isula-build --tag=d_matrix docker_images/matrix/
isula-build --tag=d_vpn docker_images/vpn/
isula-build --tag=d_vlc docker_images/vlc/
isula-build --tag=d_hostm docker_images/hostm/


isula login

# If you want to use your custom docker containers and upload them into
# docker hub, change the docker username with your own docker username.
docker_name=thomahol

container_name=d_router
docker tag "${container_name}" "${docker_name}"/"${container_name}"
docker push "${docker_name}"/"${container_name}"

container_name=d_ixp
docker tag "${container_name}" "${docker_name}"/"${container_name}"
docker push "${docker_name}"/"${container_name}"

container_name=d_host
docker tag "${container_name}" "${docker_name}"/"${container_name}"
docker push "${docker_name}"/"${container_name}"

container_name=d_ssh
docker tag "${container_name}" "${docker_name}"/"${container_name}"
docker push "${docker_name}"/"${container_name}"

container_name=d_measurement
docker tag "${container_name}" "${docker_name}"/"${container_name}"
docker push "${docker_name}"/"${container_name}"

container_name=d_dns
docker tag "${container_name}" "${docker_name}"/"${container_name}"
docker push "${docker_name}"/"${container_name}"

container_name=d_switch
docker tag "${container_name}" "${docker_name}"/"${container_name}"
docker push "${docker_name}"/"${container_name}"

container_name=d_matrix
docker tag "${container_name}" "${docker_name}"/"${container_name}"
docker push "${docker_name}"/"${container_name}"

container_name=d_vpn
docker tag "${container_name}" "${docker_name}"/"${container_name}"
docker push "${docker_name}"/"${container_name}"

container_name=d_vlc
docker tag "${container_name}" "${docker_name}"/"${container_name}"
docker push "${docker_name}"/"${container_name}"

container_name=d_hostm
docker tag "${container_name}" "${docker_name}"/"${container_name}"
docker push "${docker_name}"/"${container_name}"
