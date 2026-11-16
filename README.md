Nama : Amelinda Fedora Faragusti

NPM : 2506540475

Kelas : PBP F

## Deskripsi Proyek 

MyPortfolio Mobile adalah aplikasi mobile berbasis Flutter yang menjadi pendamping website portofolio pribadi saya (Django).Proyek ini dikerjakan sebagai tugas individu untuk mata kuliah PBP (Pemrograman Berbasis Platform), Semester Gasal 2026/2027.

## Progres Mingguan

Week 8: Basic Flutter.

### Tugas 1 

1. Flutter adalah UI framework deklaratif berbasis widget: hampir semua yang tampil di layar adalah widget, dan widget-widget itu disusun membentuk struktur pohon yang disebut widget tree. Widget yang membungkus widget lain disebut parent, sedangkan yang berada di dalamnya disebut child. Parent menentukan batasan ukuran (constraints) bagi child-nya, child menentukan ukurannya sendiri di dalam batasan tersebut, lalu parent yang menentukan posisinya. Ketika ada perubahan, Flutter membangun ulang (rebuild) bagian pohon yang terdampak, bukan seluruh aplikasi. Pada proyek ini, pohonnya kira-kira seperti berikut: MyApp → MaterialApp → MyHomePage → Scaffold → (AppBar dan Padding → Column → [Row berisi 3 InfoCard, SizedBox, Center → Column → [Padding → Text, GridView berisi 3 ItemCard]]). Misalnya Column adalah parent dari Row, SizedBox, dan Center, sehingga ketiganya disusun vertikal oleh Column. Begitu pula Card adalah parent dari Container pada InfoCard, dan Material adalah parent dari InkWell pada ItemCard.

2. Widget yang digunakan dan fungsinya.
- `MyApp`: widget root buatan sendiri (StatelessWidget) yang mengembalikan MaterialApp.
- `MaterialApp`: widget root dengan style Material Design yang mengatur judul, tema (ThemeData dengan ColorScheme.fromSeed), dan halaman awal (home).
- `MyHomePage`: widget halaman utama buatan sendiri (StatelessWidget) yang menyusun seluruh tampilan menu.
- `Scaffold`: menyediakan struktur visual dasar halaman (AppBar, body, dan tempat SnackBar muncul).
- `AppBar`: menampilkan bar bagian atas halaman aplikasi (judul "MyPortfolio").
- `Padding`: memberi jarak di sekeliling widget lain, misalnya pada body halaman utama.
- `Column`: menyusun child secara vertikal.
- `Row`: baris horizontal untuk menampilkan 3 InfoCard secara sejajar.
- `SizedBox`: memberi jarak kosong dengan ukuran tertentu antar-widget.
- `Center`: menempatkan child di tengah ruang yang tersedia (membungkus pesan sambutan dan kisi tombol).
- `Text`: menampilkan teks (pesan sambutan, judul dan isi kartu, nama tombol, dan isi SnackBar).
- `GridView.count`: menampilkan kartu tombol dalam tata letak kisi 3 kolom, shrinkWrap membuat ukuran kisi menyesuaikan tinggi konten anaknya.
- `InfoCard`: widget reusable buatan sendiri untuk menampilkan satu pasang judul (title) dan isi (content), dipakai untuk NPM, Name, dan Class.
- `Card`: kartu dengan style Material dengan efek bayangan (elevation 2) sebagai wadah InfoCard.
- `Container`: wadah yang mengatur lebar kartu (lebar layar dibagi 3,5) dan padding.
- `ItemCard`: widget reusable buatan sendiri untuk satu tombol ikon dan teks pada menu.
- `Material`: memberi warna latar (dari item.color) dan sudut membulat pada ItemCard, serta dibutuhkan agar efek sentuh tampil.
- `InkWell`: membuat kartu bisa disentuh dengan ripple effect, onTap dipakai untuk memunculkan SnackBar.
- `Icon`: menampilkan ikon pada tiap tombol.
- `ScaffoldMessenger`: pengelola SnackBar, dipakai lewat ScaffoldMessenger.of(context) untuk menampilkan dan menyembunyikan SnackBar.
- `SnackBar`: notifikasi bar di bawah layar dengan pesan "Kamu telah menekan tombol [Nama Tombol]!".

3. MaterialApp adalah widget yang membungkus aplikasi dengan berbagai konfigurasi dasar Material Design, antara lain tema (ThemeData), halaman awal (home), judul aplikasi, sistem navigasi/routing (Navigator), dan dukungan lokalisasi. Banyak widget Material seperti Scaffold, AppBar, dan SnackBar bergantung pada informasi yang disediakan oleh widget induk di atasnya, misalnya Theme, MediaQuery, Navigator, dan ScaffoldMessenger. Dengan menaruh MaterialApp di posisi paling atas, semua widget di bawahnya otomatis bisa mengakses tema dan layanan tersebut lewat BuildContext. Pada proyek ini, tema yang diatur di MaterialApp (seed color indigo) dipakai misalnya untuk warna AppBar lewat Theme.of(context).colorScheme.primary. Secara teknis MaterialApp tidak wajib (misalnya bisa memakai CupertinoApp untuk gaya iOS), tetapi untuk aplikasi bergaya Material ia adalah pilihan paling praktis sehingga umum dipakai sebagai root.

4. StatelessWidget adalah widget yang tidak memiliki state internal yang berubah. Tampilannya hanya bergantung pada data konfigurasi yang diberikan lewat constructor, sehingga cukup mengimplementasikan metode build dan tidak ada objek State yang perlu dibuat dan dikelola. StatefulWidget memiliki objek State terpisah yang menyimpan data yang bisa berubah selama aplikasi berjalan. Ketika data itu diubah lewat setState(), Flutter membangun ulang widget tersebut. State juga punya siklus hidup seperti initState() dan dispose(). Contohnya, pada aplikasi bawaan Flutter, MyHomePage dibuat sebagai StatefulWidget karena harus mengelola variabel penghitung (_counter) yang berubah setiap tombol ditekan. Pada halaman menu portofolio ini, seluruh elemen antarmuka (identitas pemilik, kartu menu, dan tombol) bersifat tetap dan tidak perlu menyimpan atau mengubah state lokal secara dinamis, sehingga StatelessWidget adalah pilihan yang tepat karena lebih sederhana. Maka StatelessWidget dipilih untuk tampilan statis seperti MyHomePage, InfoCard, dan ItemCard, sedangkan StatefulWidget dipilih ketika tampilan perlu berubah secara dinamis, misalnya counter, input form, toggle/checkbox, animasi, atau data yang dimuat lalu ditampilkan ulang.

5. BuildContext adalah objek yang merepresentasikan lokasi sebuah widget di dalam widget tree. Ia penting karena lewat BuildContext sebuah widget bisa "melihat ke atas" pohon untuk mengambil informasi dari widget induknya, seperti tema, ukuran layar, navigator, atau scaffold. Flutter memberikannya sebagai parameter pada metode build(BuildContext context). Pada proyek ini, BuildContext dipakai misalnya pada Theme.of(context).colorScheme.primary untuk mengambil warna tema pada AppBar, MediaQuery.of(context).size.width / 3.5 untuk menyesuaikan lebar InfoCard dengan lebar layar, dan ScaffoldMessenger.of(context).showSnackBar(...) untuk menampilkan SnackBar. Perlu diingat bahwa context yang dipakai harus berada di bawah widget yang dicari dalam pohon, karena pencarian hanya naik ke atas.

6. Hot reload memasukkan perubahan kode terbaru ke dalam aplikasi yang sedang berjalan lalu membangun ulang widget tree, tanpa menjalankan ulang aplikasi dari awal. Fitur ini dimungkinkan oleh kompilasi Just-In-Time (JIT) pada mode development, sehingga hasil perubahan terlihat dalam hitungan milidetik dan state aplikasi tetap dipertahankan. Hot reload dipicu dengan menekan r di terminal (atau ikon petir di VS Code), dan cocok untuk perubahan tampilan seperti warna, teks, atau tata letak. Hot restart (tombol R di terminal) menjalankan ulang aplikasi dari main() sehingga state direset ke kondisi awal, tetapi tetap lebih cepat daripada menjalankan ulang aplikasi sepenuhnya karena tidak perlu proses build native dari nol. Kita tidak bisa hanya mengandalkan hot reload ketika mengubah hal yang hanya dijalankan saat aplikasi dimulai, misalnya isi main(), nilai awal variabel global atau static, atau inisialisasi state di initState(), untuk ini perlu hot restart. Full restart (stop lalu flutter run lagi) diperlukan ketika mengubah sisi native atau konfigurasi proyek, seperti menambah dependency/plugin di pubspec.yaml, menambah asset atau font, mengubah AndroidManifest.xml atau berkas iOS (izin, ikon, dan sebagainya), serta kode native lainnya, karena perubahan tersebut harus di-build ulang.

Selama proses pengerjaan, AI tools yang saya gunakan adalah Claude (Anthropic) karena baru pertama kali mengenal dart dan flutter. Strategi yang saya lakukan selama proses pengerjaan tugas adalah meng upload pdf penugasan dan cek ceklist dari tugas tersebut. Ketika ada yang kurang saya tidak langsung menyuruh AI untuk memberikan code atau jawaban yang tepat, sisanya saya explore sendiri melalui browser. Keterbatasan AI adalah tidak bisa menjalankan Flutter di environment nya sehingga saya melakukan cek secara berkala di vs code saya dan juga saya tidak langsung percaya dengan hasil yang diberikan oleh AI sehingga saya selalu double check.

