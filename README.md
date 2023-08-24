# Kubernetes Repository Guide
```
.
└── Kubernetes
    ├── Package
    │   ├── eksctl.sh
    │   ├── kubectl.sh
    │   └── helm.sh
    │
    ├── EKS
    │   └── cluster.yaml
    │       ├── EC2
    │       └── Fargate
    └── k8s
        ├── Pod
        │   ├── CPU - Memory
        │   ├── ENV
        │   └── Volume
        │       ├── emptyDir
        │       ├── HostPath
        │       └── Persistent Volume Claim
        │ 
        ├── Deployment
        │   ├── Recreate
        │   └── RollingUpdate
        │
        ├── Service
        │   ├── ClusterIP
        │   ├── ExternalName
        │   ├── LoadBalancer
        │   │   └── NLB
        │   ├── NodePort
        │   └── headless service
        │
        ├── Ingress
        │   └── ALB Controller
```
