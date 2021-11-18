resource "aws_key_pair" "bastion" {
  key_name   = "${var.effort}-${var.environment}-bastion"
  public_key = var.bastion_public_key
}

resource "aws_key_pair" "internal" {
  key_name   = "${var.effort}-${var.environment}-internal"
  public_key = var.internal_public_key
}