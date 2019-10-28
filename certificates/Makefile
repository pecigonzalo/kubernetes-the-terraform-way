default: ca admin workers controllers proxy scheduler kubernetes service-account

CERTS:=ca-key.pem ca.csr ca.pem
$(CERTS):
	cfssl gencert -initca ca-csr.json | cfssljson -bare ca

.PHONY: ca
ca: $(CERTS)

.PHONY: admin
admin:
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-profile=kubernetes \
		admin-csr.json | cfssljson -bare admin

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

.PHONY: kubernetes
kubernetes:
	./gen-kubernetes-cert.sh

.PHONY: service-account
service-account:
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-profile=kubernetes \
		service-account-csr.json | cfssljson -bare service-account
