<h1 align="center"> Create EKS Cluster with eksctl</h1>
<p align="center"><img src="https://eksctl.io/assets/images/logo.png" width="100"></p>

[eksctl] is an Packages for efficient creation and management of EKS clusters. It is also based on the Cloud Formation stack.

----
[eksctl]: https://eksctl.io/

# Install eksctl
```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/bin
```

# Create Cluster.yaml
```
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: dev-eks-cluster
  version: "1.27"
  region: ap-northeast-2
  tags:
    karpenter.sh/discovery: dev-eks-cluster

iamIdentityMappings:
  - arn: arn:aws:iam::<Account ID>:role/PowerUserAccess
    groups:
      - system:masters
    username: admin
    noDuplicateARNs: true

iam:
  withOIDC: true
  serviceAccounts:
  - metadata:
      name: aws-load-balancer-controller
      namespace: kube-system
    wellKnownPolicies:
      awsLoadBalancerController: true
  - metadata:
      name: cert-manager
      namespace: cert-manager
    wellKnownPolicies:
      certManager: true

vpc:
  subnets:
    public:
      <region>a: { id: public_a }
      <region>b: { id: public_b }
      <region>c: { id: public_c }
    private:
      <region>a: { id: private_a }
      <region>b: { id: private_b }
      <region>c: { id: private_c }

managedNodeGroups:
  - name: dev-ng
    labels: { app: worker }
    instanceName: dev-ng
    instanceType: c5.large
    desiredCapacity: 3
    minSize: 3
    maxSize: 20
    privateNetworking: true
```
# export Subnet Name
```
export public_a=`aws ec2 describe-subnets --filters "Name=tag:Name,Values=*<env>-public-a*" --query "Subnets[].SubnetId[]" --output text`
export public_b=`aws ec2 describe-subnets --filters "Name=tag:Name,Values=*<env>-public-b*" --query "Subnets[].SubnetId[]" --output text`
export public_c=`aws ec2 describe-subnets --filters "Name=tag:Name,Values=*<env>-public-c*" --query "Subnets[].SubnetId[]" --output text`
export private_a=`aws ec2 describe-subnets --filters "Name=tag:Name,Values=*<env>-private-a*" --query "Subnets[].SubnetId[]" --output text`
export private_b=`aws ec2 describe-subnets --filters "Name=tag:Name,Values=*<env>-private-b*" --query "Subnets[].SubnetId[]" --output text`
export private_c=`aws ec2 describe-subnets --filters "Name=tag:Name,Values=*<env>-private-c*" --query "Subnets[].SubnetId[]" --output text`
```

# Change to Subnet ID on Cluster.yaml
```
sed -i "s|public_a|$public_a|g" cluster.yaml
sed -i "s|public_b|$public_b|g" cluster.yaml
sed -i "s|public_c|$public_c|g" cluster.yaml
sed -i "s|private_a|$private_a|g" cluster.yaml
sed -i "s|private_b|$private_b|g" cluster.yaml
sed -i "s|private_c|$private_c|g" cluster.yaml
```

# Create EKS Cluster
```
eksctl create cluster -f cluster.yaml
```