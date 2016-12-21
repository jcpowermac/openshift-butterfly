### openshift-butterfly

Run [butterfly](https://github.com/paradoxxxzero/butterfly) in [OpenShift](https://github.com/openshift/origin)


Create new project and process the template.
```
oc new-project butterfly
curl https://raw.githubusercontent.com/jcpowermac/openshift-butterfly/master/butterfly-template.yml | oc process -f - | oc create -f -
```

This project uses the work from [rhsyseng/container-rhel-examples](https://github.com/RHsyseng/container-rhel-examples/tree/master/starter-arbitrary-uid).
