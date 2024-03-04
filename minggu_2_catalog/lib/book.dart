class Book {
 String name;
 String image;
 String description;
 double rate;
 int page;
 String categoryBook;
 String language;


 Book({
   required this.name,
   required this.image,
   required this.description,
   required this.rate,
   required this.page,
   required this.categoryBook,
   required this.language,
 });
}


List<Book> listBook = [
 Book(
     name: 'Redhat',
     image: 'images/buku-redhat.png',
     description:
         'Red Hat adalah salah satu perusahaan terbesar dan dikenal untuk dedikasinya atas perangkat lunak sumber terbuka. Red Hat didirikan pada 1993 dan bermarkas di Raleigh, North Carolina, Amerika Serikat. Red Hat terkenal karena produknya Red Hat Linux salah satu distro Linux utama.',
     rate: 4.3,
     page: 229,
     categoryBook: 'Sysadmin IDN',
     language: 'IDN'),
 Book(
     name: 'Docker',
     image: 'images/buku-docker.png',
     description:
         'Docker adalah sekumpulan platform sebagai produk layanan yang menggunakan virtualisasi tingkat OS untuk mengirimkan perangkat lunak dalam paket yang disebut kontainer.',
     rate: 4.2,
     page: 210,
     categoryBook: 'Sysadmin IDN',
     language: 'IDN'),
 Book(
     name: 'Hyper-V',
     image: 'images/buku-hyper-v.png',
     description:
         'Docker adalah sekumpulan platform sebagai produk layanan yang menggunakan virtualisasi tingkat OS untuk mengirimkan perangkat lunak dalam paket yang disebut kontainer.',
     rate: 4.2,
     page: 210,
     categoryBook: 'Sysadmin IDN',
     language: 'IDN'),
 Book(
     name: 'NMS',
     image: 'images/buku-nms.png',
     description:
         'Network Monitoring System (NMS) merupakan tool untuk melakukan monitoring/pengawasan pada elemen-elemen dalam jaringan komputer. Fungsi dari NMS adalah melakukan pemantauan terhadap kualitas SLA (Service Level Agreement) dari Bandwidth yang digunakan.',
     rate: 4.4,
     page: 210,
     categoryBook: 'Sysadmin IDN',
     language: 'IDN'),
 Book(
     name: 'VPN',
     image: 'images/buku-vpn.png',
     description:
         'Virtual Private Network atau jaringan pribadi maya memperluas jaringan pribadi di jaringan publik dan memungkinkan pengguna untuk mengirim dan menerima data di jaringan bersama atau publik seolah-olah perangkat komputasi mereka terhubung langsung ke jaringan pribadi.',
     rate: 4.4,
     page: 210,
     categoryBook: 'Network IDN',
     language: 'IDN'),
 Book(
     name: 'Openstack',
     image: 'images/buku-openstack-admin.png',
     description:
         'OpenStack adalah perangkat lunak bebas dan open-source software platform untuk cloud computing, sebagian besar digunakan sebagai Infrastructure as a Service, di mana server virtual dan sumber daya lain tersedia untuk pelanggan',
     rate: 4.5,
     page: 210,
     categoryBook: 'Network IDN',
     language: 'IDN'),
];





