provider "google" {
    credentials = file("CHANGE_IT_service_account.json")
    project     = "terraform-demo-skd1"
    region      = var.vm-location["region"]
}

provider "google" {
    credentials = file("CHANGE_IT_service_account.json")
    project     = "terraform-demo-skd1"
    region      = "us-east1"
    alias       = "east"
}

module "mysql-vm" {
    source = "/Users/work/Documents/TERRAFORM/modules/vms/mysql"

    instance-name = "${var.instance-name}-${var.environment}"
    machine-type = var.machine-type
    vm-location = var.vm-location
    mysql_image = var.mysql_image
    vpc-network-name = var.vpc-network-name
//    mysql-static-ip = google_compute_address.ip_address.address

    providers = {
        google = google.east
    }

}
