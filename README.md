# tk2_pbp

#### Nama Anggota Kelompok:

- Adillah Putri - 2006529114
- Adnan Mukhtar - 2006485245
- Adrian Ardizza - 2006524896
- Ahmad Naufan Wicaksonoputra - 2006533181
- Muhammad Arieksha Aliadarma - 2006535073
- Raudhotul Jannah - 2006536220
- Romi Fadhurrohman Nabil - 2006535016

#### Deskripsi Aplikasi:

Di masa pandemi Covid-19 ini, kebutuhan akan plasma konvalesen semakin meningkat seiring dengan bertambahnya jumlah masyarakat yang terinfeksi Covid-19. Berbagai penelitian membuktikan bahwa plasma konvalesen dapat meringankan gejala yang dialami pasien Covid-19, mempercepat proses penyembuhan, hingga menurunkan resiko kematian pasien Covid-19. Sayangnya, permintaan plasma konvalesen ini tidak sebanding dengan ketersediaannya. Oleh karena itu, kelompok kami berencana untuk merancang aplikasi website untuk mempermudah pencarian donor plasma darah konvalesen.

Manfaat aplikasi ini untuk masyarakat umum:

- Mempermudah pencarian donor konvalesen untuk pasien yang terkena COVID-19 dan tidak memiliki keluarga yang sudah pernah terkena COVID.
- Mempermudah donor yang ingin membantu pasien COVID-19 untuk memberikan donasi plasma konvalesen.

#### Modul:

- Landing Page: Naufan
- Lokasi Donor Darah: Aksha
- Form Donor: Adillah
- Form Pencari Donor: Adnan
- FAQ: Rara
- Dashboard Donor: Romi
- Dashboard Pencari Donor: Adrian

#### Langkah-Langkah untuk Integrasi ke Web Service:

1. Mengimplementasikan support untuk Cookie-based authentication dengan library Dart http (dapat dilakukan dengan map dan sebuah wrapper class).
2. Mengimplementasikan REST API pada backend Django dengan menggunakan JsonResponse atau JSON Serializer Django.
3. Mengimplementasikan desain frontend mobile berdasarkan desain website yang sudah ada sebelumnya.
4. Mengimplementasikan frontend widget agar sesuai dengan desain aplikasi mobile.
5. Melakukan integrasi frontend-backend dengan menggunakan konsep asynchronous HTTP.

#### Persona:

| No  | Nama  | Bio                                                                                                                                                                                                                       | Tujuan                                                                                          | Tantangan                                                                                                                  |
| --- | ----- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| 1   | Aksha | Aksha adalah seorang mahasiswa berumur 19 tahun. Aksha pernah terinfeksi Covid-19. Karena keinginannya untuk membantu mencegah penyebaran Covid-19, dia berniat untuk menyumbangkan plasma darah konvalesennya            | Menyumbangkan plasma darah konvalesen, Menemukan orang yang membutuhkan plasma darah konvalesen | Sulit mencari orang yang membutuhkan plasma konvalesen, Tidak memiliki wawasan luas mengenai donor plasma darah konvalesen |
| 2   | Rara  | Rara adalah seorang mahasiswa berumur 20 tahun. Dia sedang menjalani perawatan Covid-19. Rara ingin menjalani terapi plasma konvalesen, tetapi rumah sakit tempat ia dirawat tidak ada stok plasma konvalesen yang cocok. | Mendapatkan pendonor yang compatible, Menemukan pendonor yang terpercaya.                       | Sulit mencari pendonor plasma darah konvalesen yang cocok dan terpercaya.                                                  |
|     |       |                                                                                                                                                                                                                           |                                                                                                 |                                                                                                                            |
