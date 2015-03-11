FROM debian

MAINTAINER Thomas Sarboni, tsarboni@linagora.com

WORKDIR /home/hublin

# Update APT cache
RUN apt-get update

# Install Ansible
RUN apt-get install python-pip python-dev libyaml-dev -y
RUN pip install ansible

# Upload everything needed by Ansible
ADD . /home/hublin

# Update inventory file to match localhost
RUN echo '[hublin-local]' > /home/hublin/inventory
RUN echo 'localhost' >> /home/hublin/inventory

# Deploy nodejs on hublin host using Ansible
RUN ansible-playbook -i inventory hublin.yml --tags node

# Deploy mongodb on hublin host using Ansible
#RUN ansible-playbook -i inventory hublin.yml --tags mongo

# Deploy redis on hublin host using Ansible
#RUN ansible-playbook -i inventory hublin.yml --tags redis

# Deploy hublin and coturn on hublin host using Ansible
RUN ansible-playbook -i inventory hublin.yml --tags hublin,turn

