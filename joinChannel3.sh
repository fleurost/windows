
# Join peer0.org1.example.com to the channel.
docker exec  -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.hospital.com/users/Admin@org1.hospital.com/msp"  peer0.org2.hospital.com peer channel fetch config -o orderer.hospital.com:7050 -c rschannel --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hospital.com/msp/tlscacerts/tlsca.hospital.com-cert.pem
docker exec  -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.hospital.com/users/Admin@org1.hospital.com/msp"  peer0.org2.hospital.com peer channel join -b rschannel_config.block

# Join peer1.org1.example.com to the channel.
docker exec  -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.hospital.com/users/Admin@org1.hospital.com/msp"  peer1.org2.hospital.com peer channel fetch config -o orderer.hospital.com:7050 -c rschannel --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hospital.com/msp/tlscacerts/tlsca.hospital.com-cert.pem
docker exec  -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.hospital.com/users/Admin@org1.hospital.com/msp"  peer1.org2.hospital.com peer channel join -b rschannel_config.block
