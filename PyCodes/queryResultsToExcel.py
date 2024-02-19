import os
import pandas as pd

def aranan_degeri_bul_ve_excel_olustur(file_path, aranacak_deger, kac_satir_sonrasi, baslangic_sutun, bitis_sutun):
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
            # klasor_ad = os.path.join("sonuclar", f"sonuclar_{dosya_adi}")
            klasor_ad = os.path.join("sonuclar")
            # Klasörü olustur
            if not os.path.exists(klasor_ad):
                os.makedirs(klasor_ad)

            # Excel dosyasina yaz
            excel_adi = f"{dosya_adi}_sonuclar"
            excel_path = os.path.join(klasor_ad, f"{excel_adi}.xlsx")
            with pd.ExcelWriter(excel_path, engine='xlsxwriter') as writer:
                for i, result in enumerate(results):
                    sheet_name = f"Sonuc_{i + 1}"
                    df = pd.DataFrame(result, columns=['Veri'])
                    df.iloc[:, baslangic_sutun:bitis_sutun+1].to_excel(writer, sheet_name=sheet_name, index=False)

                    # Genislikleri ayarla (Örnegin, 150 genislik)
                    for col_num, value in enumerate(df.columns.values):
                        writer.sheets[sheet_name].set_column(col_num, col_num, 150)

            print(f"{num_results} adet sonuç bulundu. Sonuçlar '{klasor_ad}' klasörüne ve '{excel_path}' Excel dosyasina kaydedildi.")

    except FileNotFoundError:
        print(f"Dosya bulunamadi: {file_path}")

# Kullanim örnegi:
dosya_yolu = 'dosya11.txt'  # Dosya yolunu kendi dosya yolunuzla degistirin
aranacak_deger = 'Query #'
kac_satir_sonrasi = 54
baslangic_sutun = 0
bitis_sutun = 11

aranan_degeri_bul_ve_excel_olustur(dosya_yolu, aranacak_deger, kac_satir_sonrasi, baslangic_sutun, bitis_sutun)
