apply:
	terraform -chdir=./first_instance init
	terraform -chdir=./first_instance plan
	@echo "yes" | terraform -chdir=./first_instance apply

destroy:
	terraform -chdir=./first_instance destroy