if [ -z ${1} ]; then
	ls | grep hospital-network
	exit
fi

VERSION=$1

composer card delete -c PeerAdmin@byfn-network-org1
composer card delete -c PeerAdmin@byfn-network-org2
composer card delete -c bob@hospital-network
composer card delete -c alice@hospital-network
rm -rv alice
rm -rv bob


echo "INSERT_ORG1_CA_CERT: "
awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' crypto-config/peerOrganizations/org1.hospital.com/peers/peer0.org1.hospital.com/tls/ca.crt > ./tmp/INSERT_ORG1_CA_CERT

echo "INSERT_ORG2_CA_CERT: "
awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' crypto-config/peerOrganizations/org2.hospital.com/peers/peer0.org2.hospital.com/tls/ca.crt > ./tmp/INSERT_ORG2_CA_CERT

echo "INSERT_ORDERER_CA_CERT: "
awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' crypto-config/ordererOrganizations/hospital.com/orderers/orderer.hospital.com/tls/ca.crt > ./tmp/INSERT_ORDERER_CA_CERT


cat << EOF > ./byfn-network-org1.json
{
    "name": "byfn-network",
    "x-type": "hlfv1",
    "version": "1.0.0",
	"client": {
		"organization": "org1",
		"connection": {
			"timeout": {
				"peer": {
					"endorser": "2100",
					"eventHub": "2100",
					"eventReg": "2100"
				},
				"orderer": "2100"
			}
		}
	},
    "channels": {
        "rschannel": {
            "orderers": [
                "orderer.hospital.com"
            ],
            "peers": {
                "peer0.org1.hospital.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                },
                "peer1.org1.hospital.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                },
                "peer0.org2.hospital.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                },
                "peer1.org2.hospital.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                }
            }
        }
    },
    "organizations": {
        "org1": {
            "mspid": "Org1MSP",
            "peers": [
                "peer0.org1.hospital.com",
                "peer1.org1.hospital.com"
            ],
            "certificateAuthorities": [
                "ca.org1.hospital.com"
            ]
        },
        "org2": {
            "mspid": "Org2MSP",
            "peers": [
                "peer0.org2.hospital.com",
                "peer1.org2.hospital.com"
            ],
            "certificateAuthorities": [
                "ca.org2.hospital.com"
            ]
        }
    },
    "orderers": {
        "orderer.hospital.com": {
            "url": "grpcs://192.168.56.107:7050",
            "grpcOptions": {
                "ssl-target-name-override": "orderer.hospital.com"
            },
            "tlsCACerts": {
                "pem": "`cat ./tmp/INSERT_ORDERER_CA_CERT`"
            }
        }
    },
    "peers": {
        "peer0.org1.hospital.com": {
            "url": "grpcs://192.168.56.108:7051",
            "grpcOptions": {
                "ssl-target-name-override": "peer0.org1.hospital.com"
            },
            "tlsCACerts": {
                "pem": "`cat ./tmp/INSERT_ORG1_CA_CERT`"
            }
        },
        "peer1.org1.hospital.com": {
            "url": "grpcs://192.168.56.108:8051",
            "grpcOptions": {
                "ssl-target-name-override": "peer1.org1.hospital.com"
            },
            "tlsCACerts": {
                "pem": "`cat ./tmp/INSERT_ORG1_CA_CERT`"
            }
        },
        "peer0.org2.hospital.com": {
            "url": "grpcs://192.168.56.109:9051",
            "grpcOptions": {
                "ssl-target-name-override": "peer0.org2.hospital.com"
            },
            "tlsCACerts": {
                "pem": "`cat ./tmp/INSERT_ORG2_CA_CERT`"
            }
        },
        "peer1.org2.hospital.com": {
            "url": "grpcs://192.168.56.109:10051",
            "grpcOptions": {
                "ssl-target-name-override": "peer1.org2.hospital.com"
            },
            "tlsCACerts": {
                "pem": "`cat ./tmp/INSERT_ORG2_CA_CERT`"
            }
        }
    },
    "certificateAuthorities": {
        "ca.org1.hospital.com": {
            "url": "https://192.168.56.108:7054",
            "caName": "ca-org1",
            "httpOptions": {
                "verify": false
            }
        },
        "ca.org2.hospital.com": {
            "url": "https://192.168.56.109:8054",
            "caName": "ca-org2",
            "httpOptions": {
                "verify": false
            }
        }
    }
}
EOF


cat << EOF > ./byfn-network-org2.json
{
    "name": "byfn-network",
    "x-type": "hlfv1",
    "version": "1.0.0",
	"client": {
		"organization": "org2",
		"connection": {
			"timeout": {
				"peer": {
					"endorser": "2100",
					"eventHub": "2100",
					"eventReg": "2100"
				},
				"orderer": "2100"
			}
		}
	},
    "channels": {
        "rschannel": {
            "orderers": [
                "orderer.hospital.com"
            ],
            "peers": {
                "peer0.org1.hospital.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                },
                "peer1.org1.hospital.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                },
                "peer0.org2.hospital.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                },
                "peer1.org2.hospital.com": {
                    "endorsingPeer": true,
                    "chaincodeQuery": true,
                    "eventSource": true
                }
            }
        }
    },
    "organizations": {
        "org1": {
            "mspid": "Org1MSP",
            "peers": [
                "peer0.org1.hospital.com",
                "peer1.org1.hospital.com"
            ],
            "certificateAuthorities": [
                "ca.org1.hospital.com"
            ]
        },
        "org2": {
            "mspid": "Org2MSP",
            "peers": [
                "peer0.org2.hospital.com",
                "peer1.org2.hospital.com"
            ],
            "certificateAuthorities": [
                "ca.org2.hospital.com"
            ]
        }
    },
    "orderers": {
        "orderer.hospital.com": {
            "url": "grpcs://192.168.56.107:7050",
            "grpcOptions": {
                "ssl-target-name-override": "orderer.hospital.com"
            },
            "tlsCACerts": {
                "pem": "`cat ./tmp/INSERT_ORDERER_CA_CERT`"
            }
        }
    },
    "peers": {
        "peer0.org1.hospital.com": {
            "url": "grpcs://192.168.56.108:7051",
            "grpcOptions": {
                "ssl-target-name-override": "peer0.org1.hospital.com"
            },
            "tlsCACerts": {
                "pem": "`cat ./tmp/INSERT_ORG1_CA_CERT`"
            }
        },
        "peer1.org1.hospital.com": {
            "url": "grpcs://192.168.56.108:8051",
            "grpcOptions": {
                "ssl-target-name-override": "peer1.org1.hospital.com"
            },
            "tlsCACerts": {
                "pem": "`cat ./tmp/INSERT_ORG1_CA_CERT`"
            }
        },
        "peer0.org2.hospital.com": {
            "url": "grpcs://192.168.56.109:9051",
            "grpcOptions": {
                "ssl-target-name-override": "peer0.org2.hospital.com"
            },
            "tlsCACerts": {
                "pem": "`cat ./tmp/INSERT_ORG2_CA_CERT`"
            }
        },
        "peer1.org2.hospital.com": {
            "url": "grpcs://192.168.56.109:10051",
            "grpcOptions": {
                "ssl-target-name-override": "peer1.org2.hospital.com"
            },
            "tlsCACerts": {
                "pem": "`cat ./tmp/INSERT_ORG2_CA_CERT`"
            }
        }
    },
    "certificateAuthorities": {
        "ca.org1.hospital.com": {
            "url": "https://192.168.56.108:7054",
            "caName": "ca-org1",
            "httpOptions": {
                "verify": false
            }
        },
        "ca.org2.hospital.com": {
            "url": "https://192.168.56.109:8054",
            "caName": "ca-org2",
            "httpOptions": {
                "verify": false
            }
        }
    }
}
EOF

org1ADMIN="./crypto-config/peerOrganizations/org1.hospital.com/users/Admin@org1.hospital.com/msp"
org2ADMIN="./crypto-config/peerOrganizations/org2.hospital.com/users/Admin@org2.hospital.com/msp"

composer card create -p ./byfn-network-org1.json -u PeerAdmin -c $org1ADMIN/signcerts/A*.pem -k $org1ADMIN/keystore/*_sk -r PeerAdmin -r ChannelAdmin -f PeerAdmin@byfn-network-org1.card
composer card create -p ./byfn-network-org2.json -u PeerAdmin -c $org2ADMIN/signcerts/A*.pem -k $org2ADMIN/keystore/*_sk -r PeerAdmin -r ChannelAdmin -f PeerAdmin@byfn-network-org2.card

composer card import -f PeerAdmin@byfn-network-org1.card --card PeerAdmin@byfn-network-org1
composer card import -f PeerAdmin@byfn-network-org2.card --card PeerAdmin@byfn-network-org2

composer network install --card PeerAdmin@byfn-network-org1 --archiveFile hospital-network@$VERSION.bna
composer network install --card PeerAdmin@byfn-network-org2 --archiveFile hospital-network@$VERSION.bna

composer identity request -c PeerAdmin@byfn-network-org1 -u admin -s adminpw -d alice
composer identity request -c PeerAdmin@byfn-network-org2 -u admin -s adminpw -d bob

composer network start -c PeerAdmin@byfn-network-org1 -n hospital-network -V $VERSION -o endorsementPolicyFile=./endorsement-policy.json -A alice -C alice/admin-pub.pem -A bob -C bob/admin-pub.pem

# create card for alice, as business network admin
composer card create -p ./byfn-network-org1.json -u alice -n hospital-network -c alice/admin-pub.pem -k alice/admin-priv.pem
composer card import -f alice@hospital-network.card

# create card for bob, as business network admin
composer card create -p ./byfn-network-org2.json -u bob -n hospital-network -c bob/admin-pub.pem -k bob/admin-priv.pem
composer card import -f bob@hospital-network.card

