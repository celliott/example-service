# example-service

Example hello-world k8s deployment using helm

## Notes

* Designed for [AWS EKS](https://aws.amazon.com/eks/)
* Deployment targets NodeGroup labeled with `node-type: general`
* SSL uses [ACM certs](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-public.html)
* Repo does not contain CI/CD pipeline for automation; all steps are manual
* Includes `HorizontalPodAutoscaler` config
* Requires cluster services:
    * [external-dns](https://github.com/kubernetes-sigs/external-dns) for updating route 53 records
    * [aws-alb-ingress-controller](https://github.com/kubernetes-sigs/aws-alb-ingress-controller) for provisioning an [AWS ALB](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
    * [metrics-server](https://github.com/kubernetes-sigs/metrics-server) used by [HorizontalPodAutoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
* Docker image adds `requirements.txt` before app to take advantage of layer caching for dependencies
* Image uses a non-root user

## To Do

* Add CI/CD pipeline

## Usage

* Print out manifests

```
$ make helm-template
```

* Build and push docker images

```
$ make docker-push
```

* Deploy to k8s

```
$ make helm-deploy
```

* In your browser, visit https://hello-world.dev.company.com

#### Delete k8s deployment

```
$ make helm-delete
```
