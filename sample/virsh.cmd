#Template for additional disk
cat > newstorage.xml <<EOF
<disk type="file" device="disk">
  <driver name="qemu" type="qcow2"/>
  <source file="/mnt/private/libvirt/newdisk1" index="2"/>
  <backingStore/>
  <target dev="vdb" bus="virtio"/>
  <alias name="newdisk1"/>
</disk>
EOF

#Run config
virsh attach-device --config rhel8.0-managed-node-1 newstorage.xml

#Attach disk
virsh attach-disk rhel8.0-managed-node-1 /mnt/private/libvirt/newdisk1.qcow2 vdb
