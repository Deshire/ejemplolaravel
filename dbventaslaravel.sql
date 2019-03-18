-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-03-2019 a las 13:43:11
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbventaslaravel`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(512) DEFAULT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `codigo`, `nombre`, `stock`, `descripcion`, `imagen`, `estado`) VALUES
(1, 1, '1234567', 'Impresora Epson Lx200', 5, 'Windows 2007', 'impresora.jpg', 'Activo'),
(2, 1, '0123', 'Impresora Epson M780', 10, 'Impresora 123', 'images.jpg', 'Activo'),
(3, 1, '456', 'Epson -M300', 10, 'es bueno ', 'grupos700.png', 'Activo'),
(4, 2, '001-0009', 'Rayola sac', 5, 'utiles para estudiantes', 'editar.png', 'Activo'),
(5, 2, '001-0077', 'Faber Castell', 15, 'utiles para temporada de colegio.', 'logout.png', 'Activo'),
(6, 8, '009-008', 'Tecnologia Tech sac', 17, 'atiende fines de semana.', 'download_page_devices.png', 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'equipos de computo', 'accesorios de computo', 1),
(2, 'Útiles', 'Útiles', 1),
(3, 'Limpieza', 'Articulos de limpieza', 1),
(4, 'Medicina', 'Articulos medicinales', 1),
(5, 'Liquidos', 'Liquidos', 1),
(6, 'Comida', 'productos de comida', 1),
(7, 'Vestimenta', 'Articulos de Vestimentas', 1),
(8, 'Servicios', 'Servicios', 1),
(9, 'Accesorios de sonido 2', 'Todos los accesorios de sonido 2', 0),
(10, 'cables', 'Tipos de cables', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `iddetalle_ingreso` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_ingreso`
--

INSERT INTO `detalle_ingreso` (`iddetalle_ingreso`, `idingreso`, `idarticulo`, `cantidad`, `precio_compra`, `precio_venta`) VALUES
(1, 2, 1, 13, '13.00', '15.00'),
(2, 3, 2, 12, '14.00', '16.00'),
(3, 3, 3, 4, '23.00', '21.00'),
(4, 3, 1, 12, '23.00', '24.00'),
(5, 8, 1, 4, '7.00', '20.00'),
(6, 9, 3, 5, '8.00', '20.00'),
(7, 10, 1, 10, '20.00', '30.00'),
(8, 11, 3, 8, '2.00', '2.00'),
(9, 12, 1, 4, '9.00', '2.00'),
(10, 13, 2, 24, '10.00', '2.00'),
(11, 14, 1, 30, '20.00', '2.00'),
(12, 15, 3, 4, '20.00', '30.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `iddetalle_venta` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`iddetalle_venta`, `idventa`, `idarticulo`, `cantidad`, `precio_venta`, `descuento`) VALUES
(1, 1, 1, 20, '15.00', '5.00'),
(2, 2, 2, 17, '35.00', '5.00'),
(3, 3, 3, 3, '19.00', '7.00'),
(4, 4, 4, 38, '25.00', '5.00'),
(5, 5, 5, 12, '45.00', '10.00'),
(6, 6, 1, 1, '15.50', '4.00'),
(7, 7, 1, 2, '15.50', '1.00'),
(8, 8, 1, 2, '15.50', '1.00');

--
-- Disparadores `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN 
  UPDATE articulo SET stock = stock - NEW.cantidad
  WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `idingreso` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`idingreso`, `idproveedor`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `estado`) VALUES
(2, 10, 'boleta', '009', '009', '2018-01-05 00:00:00', '18.00', 'A'),
(3, 7, 'boleta', '001', '002', '2018-01-03 00:00:00', '18.00', 'A'),
(4, 11, 'boleta', '123', '345', '2018-01-03 00:00:00', '18.00', 'A'),
(5, 5, 'boleta', '567', '567', '2018-01-02 00:00:00', '18.00', 'A'),
(6, 5, 'boleta', '123', '456', '2018-01-03 00:00:00', '18.00', 'A'),
(7, 7, 'factura', '123', '789', '2018-01-04 00:00:00', '18.00', 'A'),
(8, 7, 'Boleta', '567', '567', '2018-01-28 14:20:52', '18.00', 'A'),
(9, 11, 'Boleta', '1234', '1234', '2018-01-28 14:23:04', '18.00', 'A'),
(10, 7, 'Boleta', '001', '0012', '2018-01-28 14:37:44', '18.00', 'A'),
(11, 11, 'Boleta', '123', '123', '2018-01-28 14:40:55', '18.00', 'A'),
(12, 10, 'Boleta', '309', '310', '2018-01-31 07:16:40', '18.00', 'A'),
(13, 11, 'Ticket', '123', '123', '2018-01-31 07:17:58', '18.00', 'A'),
(14, 7, 'Boleta', '12', '13', '2018-01-31 09:52:04', '18.00', 'A'),
(15, 12, 'Ticket', '123', '123', '2018-02-04 09:21:25', '18.00', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_10_12_000000_create_users_table', 1),
('2014_10_12_100000_create_password_resets_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('rivas.deshire@gmail.com', '3ead78dc79f1ea75987f6e935d77ab3e8368433975bc4b149bb916297f4157a7', '2019-03-18 12:34:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `num_documento` varchar(15) DEFAULT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`) VALUES
(1, 'Inactivo', 'Montenegro Fran', 'DNI', '74123421', NULL, NULL, NULL),
(2, 'Inactivo', 'Elena Leonora', 'DNI', '73039988', NULL, NULL, NULL),
(3, 'Cliente', 'Ramon Castilla', 'PAS', '123', 'castilla urbanización 12', '989765234', 'castilla@gmail.com'),
(4, 'Cliente', 'Teresa Aguiñagp', 'DNI', '73031020', '', '989456123', 'tere@gmail.com'),
(5, 'Inactivo', 'Angelique', 'DNI', '73039988', 'Gamboa', '980776197', 'angel@gmail.com'),
(6, 'Inactivo', 'erizon', 'RUC', '0173034455', 'flores', '940958899', 'juan@gmail.com'),
(7, 'Proveedor', 'Solution', 'DNI', '3456789', '3 de junio', '989765234', 'el@gmail.com'),
(8, 'Inactivo', 'efe', 'RUC', '1234567', 'san juan', '0167890234', 'efe@gmail.com'),
(9, 'Inactivo', 'Mika ', 'DNI', '345678902', 'Suarez', '01940958867', 'mka@gmail.com'),
(10, 'Proveedor', 'July sac', 'RUC', '01234567', 'jiron july', '2508967', 'rivas.deshire@gmail.com'),
(11, 'Proveedor', 'Samsung', 'RUC', '1234567', 'junio', '989 678 567', 'lio@gmail.com'),
(12, 'Proveedor', 'Hp', 'RUC', '456789', 'Jiron julio', '989765123', 'hp@gmail.com'),
(13, 'Proveedor', 'Lima sac', 'PAS', '4567', 'Jiron Lima', '987345123', 'lima@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Deshire', 'rivas.deshire@gmail.com', '$2y$10$cG8aeD8VeY2KVsHnUpy96eQJ3JBGBVhM2XpiBy2LdXTvzvQqyUby6', 'PW0fw0zXp1N4JbHlFQLYnhjEm7CdgEHrCNwtTTPQZQQvCtKNyJwJM01BZ7gH', '2018-02-05 21:44:33', '2019-03-18 12:38:56'),
(2, 'Luis', 'luisa@gmail.com', '$2y$10$6eEmFfSAJ4L9gr2BrTSZ.ejC7YkpUStwfChyiEZBf7lrUgvXwcvY.', 'VpmgG3sexoJf16OAtv4Bpyh45fOj2isVli2ku1HsLIMrhqYKvUka1LEca7xX', '2018-02-06 14:32:36', '2019-03-18 12:38:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) NOT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_venta` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`idventa`, `idcliente`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_venta`, `estado`) VALUES
(1, 1, 'boleta', '102', '102', '2018-01-09 00:00:00', '18.00', '30.00', 'A'),
(2, 2, 'boleta', '003', '003', '2018-01-10 00:00:00', '18.00', '30.00', 'C'),
(3, 3, 'boleta', '001', '007', '2018-01-11 00:00:00', '18.00', '50.00', 'A'),
(4, 4, 'boleta', '001', '0006', '2018-01-15 00:00:00', '18.00', '25.00', 'A'),
(5, 5, 'boleta', '007', '0345', '2018-01-16 00:00:00', '18.00', '27.00', 'A'),
(6, 4, 'Factura', '123', '123', '2018-02-04 09:48:38', '18.00', '11.50', 'C'),
(7, 4, 'Factura', '009', '0093', '2018-02-05 08:45:00', '18.00', '30.00', 'A'),
(8, 3, 'Boleta', '456', '098', '2018-02-05 09:34:56', '18.00', '30.00', 'A');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD KEY `fk_articulo_categoria_idx` (`idcategoria`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`);

--
-- Indices de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_ingreso_idx` (`idingreso`),
  ADD KEY `fk_detalle_ingreso_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle_venta`),
  ADD KEY `fk_detalle_venta_articulo_idx` (`idarticulo`),
  ADD KEY `fk_detalle_venta_idx` (`idventa`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_ingreso_persona_idx` (`idproveedor`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `fk_venta_cliente_idx` (`idcliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `fk_detalle_ingreso` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_ingreso_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fk_detalle_venta` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_venta_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_persona` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_cliente` FOREIGN KEY (`idcliente`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
