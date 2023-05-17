<h1 align="center"> Create EKS Cluster in eksctl</h1>
<p align="center"><img src="https://eksctl.io/assets/images/logo.png" width="100"></p>

[eksctl] is an Packages for efficient creation and management of EKS clusters. It is also based on the Cloud Formation stack.

----
[eksctl]: https://eksctl.io/

# Installing eksctl
```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/bin
```

# Cluster.yaml
```
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: dev-eks-cluster
  version: "1.26"
  region: ap-northeast-2

iamIdentityMappings:
  - arn: arn:aws:iam::<Account ID>:role/PowerUserAccess
    groups:
      - system:masters
    username: admin
    noDuplicateARNs: true # prevents shadowing of ARNs

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
  - metadata:
      name: cluster-autoscaler
      namespace: kube-system
      labels: {aws-usage: "cluster-ops"}
    wellKnownPolicies:
      autoScaler: true
  - metadata:
      name: autoscaler-service
      namespace: kube-system
    attachPolicy:
      Version: "2012-10-17"
      Statement:
      - Effect: Allow
        Action:
        - "autoscaling:DescribeAutoScalingGroups"
        - "autoscaling:DescribeAutoScalingInstances"
        - "autoscaling:DescribeLaunchConfigurations"
        - "autoscaling:DescribeTags"
        - "autoscaling:SetDesiredCapacity"
        - "autoscaling:TerminateInstanceInAutoScalingGroup"
        - "ec2:DescribeLaunchTemplateVersions"
        Resource: '*'

vpc:
  subnets:
    public:
      ap-northeast-2a: { id: subnet-08696aff687971931 }
      ap-northeast-2b: { id: subnet-071fa2eea06bdf0a3 }
      ap-northeast-2c: { id: subnet-0f645f5f8468cf88b }
    private:
      ap-northeast-2a: { id: subnet-0ade4e90791ba5763 }
      ap-northeast-2b: { id: subnet-0c5ace59bbf435ba2 }
      ap-northeast-2c: { id: subnet-0ee85013c3133a831 }

managedNodeGroups:
  - name: dev-ng
    labels: { dev/deploy: api }
    instanceName: dev-ng
    instanceType: c5.large
    desiredCapacity: 3
    minSize: 3
    maxSize: 20
    privateNetworking: true
    tags:
      k8s.io/cluster-autoscaler/enabled: "true"
      k8s.io/cluster-autoscaler/edu-eks-cluster: "owned"
```

# Create EKS Cluster
```
eksctl create cluster -f cluster.yaml
```