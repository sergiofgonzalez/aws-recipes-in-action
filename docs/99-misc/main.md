# Misc Notes
> assorted tips & tricks

## Accessing User Data from a recently Created EC2 instance
You can access the userData assigned to a particular instance by accessing http://169.254.169.254/latest/user-data

## Accessing the InstanceId from an EC2 instance
You can use the following endpoint to obtain the InstanceId from a running EC2 server http://169.254.169.254/latest/meta-data/instance-id

## Regions and Availability Zones
Amazon EC2 is hosted in multiple locations world-wide. These locations are composed of regions and Availability Zones. Each Region is separate geographic area that features multiple, isolated locations known as Availability Zones.

Each region is completely independent. Each Availability Zone is isolated, but the AZs in a region are connected through low-latency links. When you launch an EC2 server, you can select the AZ. If you distribute your instances across multiple AZs and one instance fails, you can design your application so that an instance in another AZ can handle the requests. You can also use Elastic IP addresses to mask the failure of an instance in an AZ by rapidly remapping the address from one instance to another.
