import os

def aranan_degeri_bul_ve_Text_kaydet(file_path, aranacak_deger, kac_satir_sonrasi):
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            lines = file.readlines()

            results = []  # Her bulunan degeri ve istenilen satirlari içerecek liste

            for i, line in enumerate(lines):
                if aranacak_deger in line:
                    # Aranan degeri bulduk
                    index = i

                    # Belirtilen sayida sonraki satirlari al
                    result = lines[index:index + kac_satir_sonrasi + 1]

                    # Her bulunan degeri ve istenilen satirlari listeye ekle
                    results.append(result)

            # Bulunan deger sayisi
            num_results = len(results)

            if num_results == 0:
                print(f"{aranacak_deger} bulunamadi.")
                return None

            # Dosya adindan klasör adi olustur
            dosya_adi, _ = os.path.splitext(os.path.basename(file_path))
            klasor_ad = f"sonuclar_{dosya_adi}"

            # Klasörü olustur
            if not os.path.exists(klasor_ad):
                os.makedirs(klasor_ad)

            # Her bulunan degeri farkli bir dosyaya kaydet
            for i, result in enumerate(results):
                dosya_ad = os.path.join(klasor_ad, f"sonuc_{i + 1}.txt")
                with open(dosya_ad, 'w', encoding='utf-8') as output_file:
                    output_file.writelines(result)

            print(f"{num_results} adet sonuç bulundu. Sonuçlar '{klasor_ad}' klasörüne kaydedildi.")

    except FileNotFoundError:
        print(f"Dosya bulunamadi: {file_path}")

# Kullanim örnegi:
# dosya_yolu = 'ornek.txt'  # Dosya yolunu kendi dosya yolunuzla degistirin
# aranacak_deger = 'Aranacak Deger'
# kac_satir_sonrasi = 3
# 
# aranan_degeri_bul_ve_kaydet(dosya_yolu, aranacak_deger, kac_satir_sonrasi)
