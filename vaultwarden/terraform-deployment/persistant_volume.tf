# # Attaching persistant EBS volumne to the ec2 instance
# resource "aws_ebs_volume" "vw_data_volume" {
#   availability_zone = aws_instance.vaultwarden_ec2.availability_zone
#   size              = 1

#   tags = {
#     Name = "VW Data Volume"
#     Project = "VaultWarden by CI"
#   }
# }

# resource "aws_volume_attachment" "ebs_att" {
#   device_name = "/dev/xvdf"
#   volume_id   = aws_ebs_volume.task1_1gb_volume.id
#   instance_id = aws_instance.task1_instance.id
#   force_detach =true 
#   depends_on=[ aws_ebs_volume.task1_1gb_volume]
# }