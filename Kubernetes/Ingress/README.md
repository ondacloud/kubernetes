<h1 align="center"> Create ingress </h1>

----
# Create ingress
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dev-ing
	namespace: dev-ns
  annotations:
    <key>: <value>
spec:
  ingressClassName: alb
  rules:
  - http:
      paths: Prefix 
      - pathType: 
        path: /
        backend:
          service:
            name: <service name>
            port:
              number: <Port>
```

# Create ingress
```
kubectl apply -f ingress.yaml
```

<h1 align="center"> install ALB Controller </h1>

----
# install ALB Controller on helm

```
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=<cluster name> \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller 
```

# Attach Subnet Tag

```
Public
Key = kubernetes.io/role/elb
Value = 1
```

```
Private
Key = kubernetes.io/role/internal-elb
Value = 1