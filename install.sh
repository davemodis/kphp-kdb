mkdir -p /usr/share/engine/bin /var/log/engine/ /etc/engine /var/lib/engine

cp ./objs/bin/* /usr/share/engine/bin/
cp ./scripts/debian-init.d-engine /etc/init.d/engine
cp ./scripts/_etc_logrotate.d_engine /etc/logrotate.d/engine
cp ./scripts/start-engine /usr/share/engine/bin/
cp ./scripts/conf/* /etc/engine/

logrotate -d /etc/logrotate.d/engine
logrotate -v -f /etc/logrotate.d/engine

useradd kitten -b /var/lib/engine -u 239
chown -R kitten:kitten /var/lib/engine/

/etc/init.d/engine start qu
/etc/init.d/engine status qu

# создать бинлоги
read -p "Create binlogs for Text Engine? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

./scripts/create_binlog.sh 0x3ad50101 128 98 > /var/lib/engine/bayes-base.bin
./scripts/create_binlog.sh 0x2cb30101 1 0 > /var/lib/engine/text.bin
./scripts/create_binlog.sh 0x4fad0101 1 0 > /var/lib/engine/hints.bin
./scripts/create_binlog.sh 0x37450101 128 98 > /var/lib/engine/pmemcached.bin
./scripts/create_binlog.sh 0x2bec0101 1 0 > /var/lib/engine/friends.bin
./scripts/create_binlog.sh 0x91a70101 128 98 > /var/lib/engine/antispam.bin

chown -R kitten:kitten /var/lib/engine/


# Запсукаем движки
read -p "Do you want to start Text Engine? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1


/etc/init.d/engine start pmc
/etc/init.d/engine start by
/etc/init.d/engine start fr
/etc/init.d/engine start hi
/etc/init.d/engine start txt
