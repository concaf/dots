sudo dnf install nmap vim wget openssl python docker make git rpm-python python-pip \
		pylint go-md2man libselinux-python python-dbus kubernetes etcd -y

sudo mkdir /etc/pki/kube-apiserver
sudo openssl genrsa -out /etc/pki/kube-apiserver/serviceaccount.key 2048
sudo sudo sed -i.back '/KUBE_API_ARGS=*/c\KUBE_API_ARGS="--service_account_key_file=/etc/pki/kube-apiserver/serviceaccount.key"' /etc/kubernetes/apiserver
sudo sed -i.back '/KUBE_CONTROLLER_MANAGER_ARGS=*/c\KUBE_CONTROLLER_MANAGER_ARGS="--service_account_private_key_file=/etc/pki/kube-apiserver/serviceaccount.key"' /etc/kubernetes/controller-manager

for SERVICE in etcd kube-apiserver kube-controller-manager kube-scheduler docker kube-proxy kubelet;
do
	sudo systemctl restart $SERVICE;
	sudo systemctl enable $SERVICE;
	sudo systemctl status $SERVICE;
done
