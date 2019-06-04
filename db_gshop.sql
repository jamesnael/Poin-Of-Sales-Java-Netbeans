-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 04, 2019 at 09:57 AM
-- Server version: 10.1.34-MariaDB
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_gshop`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `query_faktur`
-- (See below for the actual view)
--
CREATE TABLE `query_faktur` (
`kd_transaksi` varchar(40)
,`kd_barang` varchar(40)
,`nama_barang` varchar(50)
,`harga` int(30)
,`jumlah` int(30)
,`subtotal` int(40)
,`total` int(40)
,`bayar` int(40)
,`kembalian` int(40)
,`tgl_transaksi` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `query_laporan_pemasokan`
-- (See below for the actual view)
--
CREATE TABLE `query_laporan_pemasokan` (
`kd_pasok` varchar(40)
,`kd_barang` varchar(40)
,`nama_barang` varchar(50)
,`jumlah` int(30)
,`kd_pemasok` varchar(40)
,`pemasok` varchar(50)
,`tgl_masuk` date
,`stok_barang` int(30)
);

-- --------------------------------------------------------

--
-- Table structure for table `tb_barang`
--

CREATE TABLE `tb_barang` (
  `kd_barang` varchar(40) NOT NULL,
  `nama_barang` varchar(50) DEFAULT NULL,
  `jenis_barang` varchar(40) DEFAULT NULL,
  `harga_beli` int(30) DEFAULT NULL,
  `harga_jual` int(30) DEFAULT NULL,
  `stok_barang` int(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_barang`
--

INSERT INTO `tb_barang` (`kd_barang`, `nama_barang`, `jenis_barang`, `harga_beli`, `harga_jual`, `stok_barang`) VALUES
('B0001', 'Indomie', 'Makanan', 2000, 2500, 208),
('B0002', 'Fruit Tea', 'Minuman', 3000, 4000, 146);

-- --------------------------------------------------------

--
-- Table structure for table `tb_keranjang`
--

CREATE TABLE `tb_keranjang` (
  `kd_transaksi` varchar(40) DEFAULT NULL,
  `kd_barang` varchar(40) DEFAULT NULL,
  `nama_barang` varchar(50) DEFAULT NULL,
  `harga` int(30) DEFAULT NULL,
  `jumlah` int(30) DEFAULT NULL,
  `subtotal` int(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tb_pasok`
--

CREATE TABLE `tb_pasok` (
  `kd_pasok` varchar(40) NOT NULL,
  `kd_barang` varchar(40) DEFAULT NULL,
  `nama_barang` varchar(50) DEFAULT NULL,
  `jumlah` int(30) DEFAULT NULL,
  `tgl_masuk` date DEFAULT NULL,
  `kd_pemasok` varchar(40) NOT NULL,
  `pemasok` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_pasok`
--

INSERT INTO `tb_pasok` (`kd_pasok`, `kd_barang`, `nama_barang`, `jumlah`, `tgl_masuk`, `kd_pemasok`, `pemasok`) VALUES
('P0001', 'B0001', 'Indomie', 20, '2019-06-03', 'PM0001', 'PT Jaya Makmur'),
('P0002', 'B0002', 'Fruit Tea', 50, '2019-06-07', 'PM0002', 'PT Mandiri');

--
-- Triggers `tb_pasok`
--
DELIMITER $$
CREATE TRIGGER `batal_beli` AFTER DELETE ON `tb_pasok` FOR EACH ROW BEGIN
update tb_barang set stok_barang = stok_barang-OLD.jumlah
WHERE
kd_barang = OLD.kd_barang;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `beli_barang` AFTER INSERT ON `tb_pasok` FOR EACH ROW BEGIN
update tb_barang
set stok_barang = stok_barang + NEW.jumlah
WHERE
kd_barang = NEW.kd_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_pemasok`
--

CREATE TABLE `tb_pemasok` (
  `kd_pemasok` varchar(40) NOT NULL,
  `nama_pemasok` varchar(50) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `no_hp` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_pemasok`
--

INSERT INTO `tb_pemasok` (`kd_pemasok`, `nama_pemasok`, `alamat`, `no_hp`) VALUES
('PM0001', 'PT Jaya Makmur', 'Bogor', '089285589229'),
('PM0002', 'PT Mandiri', 'Cisarua', '085284443936');

-- --------------------------------------------------------

--
-- Table structure for table `tb_transaksi`
--

CREATE TABLE `tb_transaksi` (
  `kd_transaksi` varchar(40) DEFAULT NULL,
  `kd_barang` varchar(40) DEFAULT NULL,
  `nama_barang` varchar(50) DEFAULT NULL,
  `harga` int(30) DEFAULT NULL,
  `jumlah` int(30) DEFAULT NULL,
  `subtotal` int(40) DEFAULT NULL,
  `total` int(40) NOT NULL,
  `bayar` int(40) NOT NULL,
  `kembalian` int(40) NOT NULL,
  `tgl_transaksi` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_transaksi`
--

INSERT INTO `tb_transaksi` (`kd_transaksi`, `kd_barang`, `nama_barang`, `harga`, `jumlah`, `subtotal`, `total`, `bayar`, `kembalian`, `tgl_transaksi`) VALUES
('T0001', 'B0001', 'Indomie', 2500, 1, 2500, 2500, 3000, 500, '0000-00-00'),
('T0002', 'B0001', 'Indomie', 2500, 1, 2500, 2500, 10000, 7500, '0000-00-00'),
('T0003', 'B0002', 'Fruit Tea', 4000, 2, 8000, 8000, 10000, 2000, '0000-00-00'),
('T0004', 'B0002', 'Fruit Tea', 4000, 1, 4000, 6500, 7000, 500, '2019-06-03'),
('T0005', 'B0002', 'Fruit Tea', 4000, 1, 4000, 4000, 5000, 1000, '2019-06-03'),
('T0006', 'B0001', 'Indomie', 2500, 2, 5000, 5000, 5000, 0, '2019-06-04');

--
-- Triggers `tb_transaksi`
--
DELIMITER $$
CREATE TRIGGER `batal_jual` AFTER DELETE ON `tb_transaksi` FOR EACH ROW BEGIN 
update tb_barang SET
stok_barang = stok_barang + OLD.jumlah
WHERE kd_barang = OLD.kd_barang;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `jual_barang` AFTER INSERT ON `tb_transaksi` FOR EACH ROW BEGIN
UPDATE tb_barang
set stok_barang = stok_barang - NEW.jumlah
WHERE kd_barang = NEW.kd_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `kd_pengguna` varchar(40) NOT NULL,
  `nama_pengguna` varchar(50) DEFAULT NULL,
  `jenis_kelamin` varchar(50) DEFAULT NULL,
  `no_hp` varchar(16) DEFAULT NULL,
  `jabatan` varchar(40) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`kd_pengguna`, `nama_pengguna`, `jenis_kelamin`, `no_hp`, `jabatan`, `username`, `password`) VALUES
('ID0001', 'James Nathanael', 'Laki-laki', '087885511858', 'Manager', 'manager', 'manager');

-- --------------------------------------------------------

--
-- Structure for view `query_faktur`
--
DROP TABLE IF EXISTS `query_faktur`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `query_faktur`  AS  select `tb_transaksi`.`kd_transaksi` AS `kd_transaksi`,`tb_transaksi`.`kd_barang` AS `kd_barang`,`tb_transaksi`.`nama_barang` AS `nama_barang`,`tb_transaksi`.`harga` AS `harga`,`tb_transaksi`.`jumlah` AS `jumlah`,`tb_transaksi`.`subtotal` AS `subtotal`,`tb_transaksi`.`total` AS `total`,`tb_transaksi`.`bayar` AS `bayar`,`tb_transaksi`.`kembalian` AS `kembalian`,`tb_transaksi`.`tgl_transaksi` AS `tgl_transaksi` from `tb_transaksi` ;

-- --------------------------------------------------------

--
-- Structure for view `query_laporan_pemasokan`
--
DROP TABLE IF EXISTS `query_laporan_pemasokan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `query_laporan_pemasokan`  AS  select `tb_pasok`.`kd_pasok` AS `kd_pasok`,`tb_pasok`.`kd_barang` AS `kd_barang`,`tb_pasok`.`nama_barang` AS `nama_barang`,`tb_pasok`.`jumlah` AS `jumlah`,`tb_pasok`.`kd_pemasok` AS `kd_pemasok`,`tb_pasok`.`pemasok` AS `pemasok`,`tb_pasok`.`tgl_masuk` AS `tgl_masuk`,`tb_barang`.`stok_barang` AS `stok_barang` from (`tb_pasok` join `tb_barang`) where (`tb_pasok`.`kd_barang` = `tb_barang`.`kd_barang`) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_barang`
--
ALTER TABLE `tb_barang`
  ADD PRIMARY KEY (`kd_barang`);

--
-- Indexes for table `tb_keranjang`
--
ALTER TABLE `tb_keranjang`
  ADD KEY `kd_barang` (`kd_barang`);

--
-- Indexes for table `tb_pasok`
--
ALTER TABLE `tb_pasok`
  ADD PRIMARY KEY (`kd_pasok`),
  ADD KEY `kd_barang` (`kd_barang`),
  ADD KEY `kd_pemasok` (`kd_pemasok`);

--
-- Indexes for table `tb_pemasok`
--
ALTER TABLE `tb_pemasok`
  ADD PRIMARY KEY (`kd_pemasok`);

--
-- Indexes for table `tb_transaksi`
--
ALTER TABLE `tb_transaksi`
  ADD KEY `kd_barang` (`kd_barang`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`kd_pengguna`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_keranjang`
--
ALTER TABLE `tb_keranjang`
  ADD CONSTRAINT `tb_keranjang_ibfk_1` FOREIGN KEY (`kd_barang`) REFERENCES `tb_barang` (`kd_barang`);

--
-- Constraints for table `tb_pasok`
--
ALTER TABLE `tb_pasok`
  ADD CONSTRAINT `tb_pasok_ibfk_1` FOREIGN KEY (`kd_barang`) REFERENCES `tb_barang` (`kd_barang`),
  ADD CONSTRAINT `tb_pasok_ibfk_2` FOREIGN KEY (`kd_pemasok`) REFERENCES `tb_pemasok` (`kd_pemasok`);

--
-- Constraints for table `tb_transaksi`
--
ALTER TABLE `tb_transaksi`
  ADD CONSTRAINT `tb_transaksi_ibfk_1` FOREIGN KEY (`kd_barang`) REFERENCES `tb_barang` (`kd_barang`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
