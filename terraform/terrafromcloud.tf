terraform {
  backend "remote" {
    organization = "PE_Serhii_Verboliuk"

    workspaces {
      name = "Iaac_sample"
    }
  }
}