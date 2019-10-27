resource "aws_route53_zone" "kttw" {
  name = "kttw.internal"

  vpc {
    vpc_id = "${module.vpc.vpc_id}"
  }

  tags = "${module.lb_label.tags}"
}

resource "aws_route53_record" "ctrl-0" {
  zone_id = "${aws_route53_zone.kttw.zone_id}"
  name    = "ctrl-0"
  type    = "CNAME"
  ttl     = "30"

  records = [
    "${module.ctrl-0.private_dns}",
  ]
}

resource "aws_route53_record" "ctrl-1" {
  zone_id = "${aws_route53_zone.kttw.zone_id}"
  name    = "ctrl-1"
  type    = "CNAME"
  ttl     = "30"

  records = [
    "${module.ctrl-1.private_dns}",
  ]
}

resource "aws_route53_record" "ctrl-2" {
  zone_id = "${aws_route53_zone.kttw.zone_id}"
  name    = "ctrl-2"
  type    = "CNAME"
  ttl     = "30"

  records = [
    "${module.ctrl-2.private_dns}",
  ]
}

resource "aws_route53_record" "wrkr-0" {
  zone_id = "${aws_route53_zone.kttw.zone_id}"
  name    = "wrkr-0"
  type    = "CNAME"
  ttl     = "30"

  records = [
    "${module.wrkr-0.private_dns}",
  ]
}

resource "aws_route53_record" "wrkr-1" {
  zone_id = "${aws_route53_zone.kttw.zone_id}"
  name    = "wrkr-1"
  type    = "CNAME"
  ttl     = "30"

  records = [
    "${module.wrkr-1.private_dns}",
  ]
}

resource "aws_route53_record" "wrkr-2" {
  zone_id = "${aws_route53_zone.kttw.zone_id}"
  name    = "wrkr-2"
  type    = "CNAME"
  ttl     = "30"

  records = [
    "${module.wrkr-2.private_dns}",
  ]
}
