# output "password" {
#   description="The password of the aws_iam_user_login_profile provisioned"
#   sensitive=true
#   value=module.aws_iam_user_login_profile.password
# }
putput "subscriptions" {
  value = [
    for subscription in data.oci_identity_region_subscriptions.activated.region_subscriptions : {
      alias  = subscription.region_key
      region = subscription.region_name
    }
  ]
}