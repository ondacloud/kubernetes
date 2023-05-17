#!/bin/bash
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.26.2/2023-03-17/bin/linux/amd64/kubectl
chmod 777 kubectl
mv kubectl /usr/bin