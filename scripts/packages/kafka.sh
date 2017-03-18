
# See also https://gist.github.com/monkut/07cd1618102cbae8d587811654c92902

VER=0.10.2.0
SRC="kafka-${VER}-src"

# Download
wget https://archive.apache.org/dist/kafka/${VER}/${SRC}.tgz
tar -zxf ${SRC}.tgz

# Build
cd ${SRC}
gradle
./gradlew jar
./gradlew releaseTarGz -x signArchives

# Install
cd ../
DIST=$(basename ${SRC}/core/build/distributions/kafka_*-${VER}.tgz .tgz)
tar zxf ${SRC}/core/build/distributions/${DIST}.tgz -C /usr/local/
rm -f /usr/local/kafka
ln -s /usr/local/$DIST /usr/local/kafka

# Cleanup
rm -rf kafka*

# Add user
#useradd kafka -m

