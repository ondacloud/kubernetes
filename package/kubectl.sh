#!/bin/bash
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.1/2023-04-19/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin