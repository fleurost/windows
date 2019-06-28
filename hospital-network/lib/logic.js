/*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

'use strict';
/**
 * Write your transction processor functions here
 */


/**
 * Handle a transaction that returns a string.
 * @param {org.hospital.record.CheckIntegrity} transaction
 * @transaction
 */
async function CheckIntegrity(transaction) {
    var diagnosaPrimer = [];
    return getAssetRegistry('org.hospital.record.DataMedis').then(function (assetRegistry) {
        return assetRegistry.getAll().then(function(resourceCollection) {
                resourceCollection.forEach(function (resource) {
                    diagnosaPrimer.push(resource.diagnosaPrimer);

                    var factory = getFactory();
                    var newEvent = factory.newEvent('org.hospital.record', 'DataMedisSent');
                    newEvent.diagnosaPrimer = diagnosaPrimer;
                    emit(newEvent);
                });

        }).catch(function(error){
            console.log(error);
        });
    });
}

/**
 * Handle a transaction that returns a string.
 * @param {org.hospital.record.TambahDataMedis} transaction
 * @transaction
 */
async function TambahDataMedis(transaction) {
  const factory = getFactory();
  let newAsset = factory.newResource('org.hospital.record', 'DataMedis', transaction.idRekMedis);

  newAsset.noRekMedis = transaction.noRekMedis;
  newAsset.pasien = transaction.pasien;
  newAsset.dokter = transaction.dokter;
  newAsset.tglMasuk = transaction.tglMasuk;
  newAsset.tglKeluar = transaction.tglKeluar;
  newAsset.alasanMasuk = transaction.alasanMasuk;
  newAsset.rujukan = transaction.rujukan;
  newAsset.anamnesis = transaction.anamnesis;
  newAsset.pemeriksaanFisik = transaction.pemeriksaanFisik;
  newAsset.riwayatAlergi = transaction.riwayatAlergi;
  newAsset.diagnosaPrimer = transaction.diagnosaPrimer;
  newAsset.diagnosaSekunder = transaction.diagnosaSekunder;
  newAsset.terapiDiRs = transaction.terapiDiRs;
  newAsset.tindakan = transaction.tindakan;
  newAsset.prognosaPenyakit = transaction.prognosaPenyakit;
  newAsset.alasanPulang = transaction.alasanPulang;
  newAsset.kondisiSaatPulang = transaction.kondisiSaatPulang;
  newAsset.rencanaTindakLanjut = transaction.rencanaTindakLanjut;

  return getAssetRegistry('org.hospital.record.DataMedis').then(function (assetRegistry) {
    return assetRegistry.add(newAsset);

  })
  .catch(function (error) {
    console.error(error);
  });  
}

/**
 * Handle a transaction that returns a string.
 * @param {org.hospital.record.TambahDataMedis} transaction
 * @transaction
 */
async function TambahDataMedis(transaction) {
  return getAssetRegistry('org.hospital.record.DataMedis').then(function (assetRegistry) {
    return assetRegistry.get(idRekMedis).then(function (asset) {
      asset.noRekMedis = newNoRekMedis;
      asset.pasien = newPasien;
      asset.dokter = newDokter;
      asset.tglMasuk = newTglMasuk;
      asset.tglKeluar = newTglKeluar;
      asset.alasanMasuk = newAlasanMasuk;
      asset.rujukan = newRujukan;
      asset.anamnesis = newAnamnesis;
      asset.pemeriksaanFisik = newPemeriksaanFisik;
      asset.riwayatAlergi = newRiwayatAlergi;
      asset.diagnosaPrimer = newDiagnosaPrimer;
      asset.diagnosaSekunder = newDiagnosaSekunder;
      asset.terapiDiRs = newTerapiDiRs;
      asset.tindakan = newTindakan;
      asset.prognosaPenyakit = newPrognosaPenyakit;
      asset.alasanPulang = newAlasanPulang;
      asset.kondisiSaatPulang = newKondisiSaatPulang;
      asset.rencanaTindakLanjut = newRencanaTindakLanjut;

      return assetRegistry.update(asset);

    })
    .catch(function (error) {
      console.error(error);
    });
  });
}


