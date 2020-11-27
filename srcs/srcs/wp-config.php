<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'ft_server' );

/** MySQL database username */
define( 'DB_USER', 'pcariou' );

/** MySQL database password */
define( 'DB_PASSWORD', 'user42' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '`*cHuPq}eIw:JQnGR k6+{c]$f2FiM;6!-?ZG!xs:MbN<mGp_7^|f6I;L?njaj^|');
define('SECURE_AUTH_KEY',  'y*--K=.ZJ3C99VZ;W(A8uCBs(Oy!>UqFsPO@2$KP6}VLPV,#pSTX3Q~/R`#Zo$X:');
define('LOGGED_IN_KEY',    'wdg57a$:*bvqPaX,G&y_;QB1m ZQ)-FzC0T 0o{7QwQK=OLyn/7}SFY?=-P7m&+C');
define('NONCE_KEY',        'vJ*zP^}A|71pQdj&g3ap}8Z.!W_]xY-m>4*mz-|ADZdbk-1-WA*)a)Te|OZw+,p!');
define('AUTH_SALT',        '|Ez!drDsZ)4A ~.</<n0[+M56rI/%EV=Boy|Vx =/XjD+9M7Q|-Ge@k*yW6kyQ6p');
define('SECURE_AUTH_SALT', '0$+fe8wWOV6An!p8QJ^|_)c6Ee9qa]T`It+v,kT=?+yN;xB0-Q|JM-a.>f^1@[|I');
define('LOGGED_IN_SALT',   'RW/6E]htBcry&y0&/*=+/^|wZI(tm4|.o.}Mx;c%ev4|#Mz)ehes8!#LRy(Ckb1a');
define('NONCE_SALT',       ',^-j$CCb4g/mA<!_UZjAq%T5&;x</[Rk; kI@=9eJe9#Z3&AT ,_a]U^+rtt<U5T');
/**#@-*/

/**
* WordPress Database Table prefix.
*
* You can have multiple installations in one database if you give each
* a unique prefix. Only numbers, letters, and underscores please!
*/
$table_prefix = 'wp_';

/**
* For developers: WordPress debugging mode.
*
* Change this to true to enable the display of notices during development.
* It is strongly recommended that plugin and theme developers use WP_DEBUG
* in their development environments.
*
* For information on other constants that can be used for debugging,
* visit the documentation.
*
* @link https://wordpress.org/support/article/debugging-in-wordpress/
*/
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
