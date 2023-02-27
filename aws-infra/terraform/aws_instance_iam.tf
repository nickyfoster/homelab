resource "aws_iam_instance_profile" "instance_profile" {
  for_each = { for host in var.private_hosts : host.name => host }

  name = "${each.key}-instance-profile"
  role = aws_iam_role.instance-role[each.key].name
}

resource "aws_iam_role" "instance-role" {
  for_each = { for host in var.private_hosts : host.name => host }

  name               = "${each.key}-instance-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

resource "aws_iam_policy_attachment" "instance_pa" {
  for_each = { for host in var.private_hosts : host.name => host }

  name = "${each.key}-instance"
  roles = [
    aws_iam_role.instance-role[each.key].name
  ]
  policy_arn = aws_iam_policy.instance_policy[each.key].arn
}

resource "aws_iam_policy" "instance_policy" {
  for_each = { for host in var.private_hosts : host.name => host }

  name   = "${each.key}-instance"
  path   = "/"
  policy = data.aws_iam_policy_document.default[each.key].json
}

data "aws_iam_policy_document" "default" {
  for_each = { for host in var.private_hosts : host.name => host }

  dynamic "statement" {
    for_each = lookup(each.value, "iam", null) == null ? {
      for iam in var.ec2_iam_default_profile_statements : iam.name => iam
      } : {
      for iam in each.value.iam : iam.name => iam
    }

    content {
      sid       = statement.key
      actions   = statement.value.actions
      resources = statement.value.resources
      effect    = statement.value.effect
    }
  }
}
