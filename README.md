Nama : Amelinda Fedora Faragusti

NPM : 2506540475

Kelas : PBP F

## Deskripsi Proyek 

MyPortfolio Mobile adalah aplikasi mobile berbasis Flutter yang menjadi pendamping website portofolio pribadi saya (Django).Proyek ini dikerjakan sebagai tugas individu untuk mata kuliah PBP (Pemrograman Berbasis Platform), Semester Gasal 2026/2027.

## Progres Mingguan

Week 8: Basic Flutter.

Week 9: Flutter Navigation, Layouts, Forms, and Input Elements.

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

### Tugas 2

1. Widget `Navigator` menampilkan halaman-halaman ke layar sebagai sebuah tumpukan (stack), dan halaman sering disebut route.
   - `Navigator.push()` menambahkan suatu route ke dalam stack route yang dikelola oleh Navigator, sehingga route yang ditambahkan berada pada paling atas stack dan ditampilkan kepada pengguna.
   - `Navigator.pop()` menghapus route yang sedang ditampilkan (route paling atas stack), sehingga aplikasi berpindah ke route yang berada di bawahnya pada stack.
   - `Navigator.pushReplacement()` menghapus route yang sedang ditampilkan dan menggantinya dengan route yang diberikan. Route lama pada atas stack digantikan langsung oleh route baru tanpa mengubah kondisi elemen stack di bawahnya.

   Perbedaan `push()` dan `pushReplacement()` ada pada apa yang dilakukan terhadap route di atas stack: `push()` menambahkan route baru di atas route yang sudah ada, sedangkan `pushReplacement()` menggantikan route yang sudah ada tersebut.

   Untuk membuka formulir dari card "Tambah Pengalaman", saya menggunakan `Navigator.push()` ke `MaterialPageRoute` yang berisi `ExperienceFormPage`. Dengan `push()`, halaman utama tetap berada di bawah formulir pada stack, sehingga pengguna dapat menekan tombol Back sistem pada perangkat atau tombol Back pada browser untuk kembali ke halaman utama.

   Opsi Home di drawer menggunakan `Navigator.pushReplacement()` ke `MyHomePage`. Halaman yang sedang tampil (misalnya formulir) diganti dengan halaman utama, sehingga pengguna kembali ke halaman utama tanpa menumpuk halaman baru di atas formulir.

2. `Scaffold` menyediakan struktur visual dasar halaman. Di proyek ini, setiap halaman memakai susunan yang sama: `appBar` untuk bar bagian atas, `drawer` untuk menu navigasi, dan `body` untuk isi halaman. Drawer menu adalah menu yang muncul dari sisi kiri layar dan berisi navigasi ke halaman-halaman lain pada aplikasi. Karena `LeftDrawer` dibuat sebagai widget tersendiri di `lib/widgets/left_drawer.dart`, komponen yang sama dipasang lewat properti `drawer: const LeftDrawer()` pada `MyHomePage`, `ProjectFormPage`, dan `ExperienceFormPage`. Dengan begitu pengguna tetap dapat mengakses navigasi aplikasi dari halaman mana pun, dan struktur halaman tetap konsisten.

   Contoh penggunaan warna tema di lebih dari satu halaman: `seedColor: Colors.indigo` diatur di `ThemeData` pada `main.dart`, lalu `AppBar` di `MyHomePage` dan `ExperienceFormPage` sama-sama memakai `Theme.of(context).colorScheme.primary` sebagai `backgroundColor`. Tombol Simpan di formulir juga memakai warna yang sama. Jika seed color diganti di satu tempat, semua halaman ikut berubah.

3. Formulir memakai `Form` sebagai wadah bagi beberapa input field, dengan `SingleChildScrollView` di dalamnya dan `Column` sebagai child untuk menyusun field secara vertikal dari atas ke bawah. Tata letak ini dipilih karena `Column` dan `Row` secara default tidak dapat di-scroll. Jika elemen yang ditampilkan melebihi ruang layar, misalnya pada layar ponsel yang sempit atau ketika papan ketik tampil, `SingleChildScrollView` membuat konten dapat digulir sehingga semua input dan tombol Simpan tetap dapat dijangkau.

   Untuk pengaturan jarak, `Padding` memberikan jarak di sekitar suatu widget (`EdgeInsets.all(16.0)` di sekeliling formulir), sedangkan `SizedBox` memberikan jarak antar elemen (misalnya `SizedBox(height: 16)` di antara field). Tanpa jarak, field akan terlalu rapat dan sulit disentuh di layar kecil. Pada `Column`, `crossAxisAlignment: CrossAxisAlignment.stretch` membuat field dan tombol memenuhi lebar layar.

4. `GlobalKey<FormState>` (`_formKey`) dipasang pada atribut `key` milik `Form`, dan berfungsi untuk mengakses form state, melakukan validasi, dan mengelola kondisi form dari luar `Form`, misalnya dari tombol Simpan. `validator` pada setiap `TextFormField` digunakan untuk memvalidasi isi field dan mengembalikan pesan error apabila input tidak memenuhi ketentuan (atau `null` jika valid). Ketika tombol Simpan ditekan, `_formKey.currentState!.validate()` menjalankan validasi terhadap seluruh field yang memiliki validator dan menampilkan pesan kesalahan pada kolom yang bermasalah. Hanya jika seluruh input valid, `showDialog()` dipanggil untuk menampilkan `AlertDialog` berisi ringkasan isian.

   Contoh nilai yang ditolak: pada field Posisi/Peran, isian berupa spasi saja (`"   "`) ditolak karena validator memeriksa `value.trim().isEmpty`, sehingga muncul pesan "Posisi tidak boleh kosong!". Contoh lain: tanggal selesai yang dipilih sebelum tanggal mulai ditolak dengan pesan "Tanggal selesai tidak boleh sebelum tanggal mulai!".

   Memilih jenis input atau papan ketik saja belum cukup karena jenis input hanya mengatur cara pengguna mengisi data, bukan aturan yang harus dipenuhi datanya. Date picker, misalnya, menjamin format tanggal yang benar, tetapi tetap membiarkan pengguna memilih tanggal selesai yang lebih awal dari tanggal mulai. Aturan seperti wajib diisi, tidak hanya spasi, batas panjang, dan urutan tanggal hanya dapat ditegakkan oleh validator.

Selama proses pengerjaan, AI tools yang saya gunakan adalah Claude (Anthropic). Strategi yang saya lakukan selama proses pengerjaan tugas adalah meng upload pdf penugasan dan cek ceklist dari tugas tersebut. Karena penugasan yang dilakukan sama persis dengan yang sudah dijelaskan di ttutorial, saya menanya AI hanya untuk validasi saja.