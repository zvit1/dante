#define CPU 257
#define MASK 258
#define SCHEDULE 259
#define CPUMASK_ANYCPU 260
#define PROCESSTYPE 261
#define SCHEDULEPOLICY 262
#define SERVERCONFIG 263
#define CLIENTCONFIG 264
#define DEPRECATED 265
#define INTERFACE 266
#define SOCKETOPTION_SYMBOLICVALUE 267
#define SOCKETPROTOCOL 268
#define SOCKETOPTION_OPTID 269
#define CLIENTRULE 270
#define HOSTID 271
#define HOSTINDEX 272
#define REQUIRED 273
#define INTERNAL 274
#define EXTERNAL 275
#define INTERNALSOCKET 276
#define EXTERNALSOCKET 277
#define REALM 278
#define REALNAME 279
#define EXTERNAL_ROTATION 280
#define SAMESAME 281
#define DEBUGGING 282
#define RESOLVEPROTOCOL 283
#define SOCKET 284
#define CLIENTSIDE_SOCKET 285
#define SNDBUF 286
#define RCVBUF 287
#define SRCHOST 288
#define NODNSMISMATCH 289
#define NODNSUNKNOWN 290
#define CHECKREPLYAUTH 291
#define EXTENSION 292
#define BIND 293
#define PRIVILEGED 294
#define IOTIMEOUT 295
#define IOTIMEOUT_TCP 296
#define IOTIMEOUT_UDP 297
#define NEGOTIATETIMEOUT 298
#define CONNECTTIMEOUT 299
#define TCP_FIN_WAIT 300
#define METHOD 301
#define CLIENTMETHOD 302
#define NONE 303
#define GSSAPI 304
#define UNAME 305
#define RFC931 306
#define PAM 307
#define BSDAUTH 308
#define COMPATIBILITY 309
#define SAMEPORT 310
#define DRAFT_5_05 311
#define CLIENTCOMPATIBILITY 312
#define NECGSSAPI 313
#define USERNAME 314
#define GROUPNAME 315
#define USER_PRIVILEGED 316
#define USER_UNPRIVILEGED 317
#define USER_LIBWRAP 318
#define LIBWRAP_FILE 319
#define ERRORLOG 320
#define LOGOUTPUT 321
#define LOGFILE 322
#define CHILD_MAXIDLE 323
#define CHILD_MAXREQUESTS 324
#define ROUTE 325
#define VIA 326
#define BADROUTE_EXPIRE 327
#define MAXFAIL 328
#define VERDICT_BLOCK 329
#define VERDICT_PASS 330
#define PAMSERVICENAME 331
#define BSDAUTHSTYLENAME 332
#define BSDAUTHSTYLE 333
#define GSSAPISERVICE 334
#define GSSAPIKEYTAB 335
#define GSSAPIENCTYPE 336
#define GSSAPIENC_ANY 337
#define GSSAPIENC_CLEAR 338
#define GSSAPIENC_INTEGRITY 339
#define GSSAPIENC_CONFIDENTIALITY 340
#define GSSAPIENC_PERMESSAGE 341
#define GSSAPISERVICENAME 342
#define GSSAPIKEYTABNAME 343
#define PROTOCOL 344
#define PROTOCOL_TCP 345
#define PROTOCOL_UDP 346
#define PROTOCOL_FAKE 347
#define PROXYPROTOCOL 348
#define PROXYPROTOCOL_SOCKS_V4 349
#define PROXYPROTOCOL_SOCKS_V5 350
#define PROXYPROTOCOL_HTTP 351
#define PROXYPROTOCOL_UPNP 352
#define USER 353
#define GROUP 354
#define COMMAND 355
#define COMMAND_BIND 356
#define COMMAND_CONNECT 357
#define COMMAND_UDPASSOCIATE 358
#define COMMAND_BINDREPLY 359
#define COMMAND_UDPREPLY 360
#define ACTION 361
#define LINE 362
#define LIBWRAPSTART 363
#define LIBWRAP_ALLOW 364
#define LIBWRAP_DENY 365
#define LIBWRAP_HOSTS_ACCESS 366
#define OPERATOR 367
#define SOCKS_LOG 368
#define SOCKS_LOG_CONNECT 369
#define SOCKS_LOG_DATA 370
#define SOCKS_LOG_DISCONNECT 371
#define SOCKS_LOG_ERROR 372
#define SOCKS_LOG_IOOPERATION 373
#define IPADDRESS 374
#define DOMAINNAME 375
#define DIRECT 376
#define IFNAME 377
#define URL 378
#define SERVICENAME 379
#define PORT 380
#define NUMBER 381
#define FROM 382
#define TO 383
#define REDIRECT 384
#define BANDWIDTH 385
#define MAXSESSIONS 386
#define UDPPORTRANGE 387
#define UDPCONNECTDST 388
#define YES 389
#define NO 390
#define BOUNCE 391
#define LDAPURL 392
#define LDAP_URL 393
#define LDAPSSL 394
#define LDAPCERTCHECK 395
#define LDAPKEEPREALM 396
#define LDAPBASEDN 397
#define LDAP_BASEDN 398
#define LDAPBASEDN_HEX 399
#define LDAPBASEDN_HEX_ALL 400
#define LDAPSERVER 401
#define LDAPSERVER_NAME 402
#define LDAPGROUP 403
#define LDAPGROUP_NAME 404
#define LDAPGROUP_HEX 405
#define LDAPGROUP_HEX_ALL 406
#define LDAPFILTER 407
#define LDAPFILTER_AD 408
#define LDAPFILTER_HEX 409
#define LDAPFILTER_AD_HEX 410
#define LDAPATTRIBUTE 411
#define LDAPATTRIBUTE_AD 412
#define LDAPATTRIBUTE_HEX 413
#define LDAPATTRIBUTE_AD_HEX 414
#define LDAPCERTFILE 415
#define LDAPCERTPATH 416
#define LDAPPORT 417
#define LDAPPORTSSL 418
#define LDAP_FILTER 419
#define LDAP_ATTRIBUTE 420
#define LDAP_CERTFILE 421
#define LDAP_CERTPATH 422
#define LDAPDOMAIN 423
#define LDAP_DOMAIN 424
#define LDAPTIMEOUT 425
#define LDAPCACHE 426
#define LDAPCACHEPOS 427
#define LDAPCACHENEG 428
#define LDAPKEYTAB 429
#define LDAPKEYTABNAME 430
#define LDAPDEADTIME 431
#define LDAPDEBUG 432
#define LDAPDEPTH 433
#define LDAPAUTO 434
#define LDAPSEARCHTIME 435
#ifndef YYSTYPE_DEFINED
#define YYSTYPE_DEFINED
typedef union {
   char    *string;
   uid_t   uid;
   ssize_t number;
} YYSTYPE;
#endif /* YYSTYPE_DEFINED */
extern YYSTYPE socks_yylval;
