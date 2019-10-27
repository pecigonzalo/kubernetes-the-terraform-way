default: ca controllers workers proxy scheduler kubernetes service-account

CERTS:=ca-key.pem ca.csr ca.pem
$(CERTS):
	cfssl gencert -initca ca-csr.json | cfssljson -bare ca

.PHONY: ca
ca: $(CERTS)

WORKERS:=wrkr-0 wrkr-1 wrkr-2
.PHONY: $(WORKERS)
$(WORKERS):
	./gen-cert.sh $@

.PHONY: workers
workers: $(WORKERS)

.PHONY: controllers
controllers:
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-profile=kubernetes \
		kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager

.PHONY: proxy
proxy:
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-profile=kubernetes \
		kube-proxy-csr.json | cfssljson -bare kube-proxy

.PHONY: scheduler
scheduler:
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-profile=kubernetes \
		kube-scheduler-csr.json | cfssljson -bare kube-scheduler

# TODO: Add hostnames
.PHONY: kubernetes
kubernetes:
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-hostname=127.0.0.1,kubernetes,10.240.96.10,10.240.128.10,10.240.160.10,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local \
		-profile=kubernetes \
		kubernetes-csr.json | cfssljson -bare kubernete

.PHONY: service-account
service-account:
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-profile=kubernetes \
		service-account-csr.json | cfssljson -bare service-account
