{
  pkgs,
  ...
}: {
  programs.gpg = {
    enable = true;
    # from https://raw.githubusercontent.com/ioerror/duraconf/master/configs/gnupg/gpg.conf
    settings = {
      no-emit-version = true;
      no-comments = true;
      keyid-format = "0xlong";
      with-fingerprint = true;
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      use-agent = true;
      keyserver = "hkps://keys.openpgp.org/";
      keyserver-options = [
        "no-honor-keyserver-url"
        "include-revoked"
      ];
      personal-cipher-preferences = "AES256 AES192 AES CAST5";
      personal-digest-preferences = "SHA512 SHA384 SHA256 SHA224";
      cert-digest-algo = "SHA512";
      default-preference-list = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
    };
  };

  home = {
    packages = with pkgs; [
      pinentry
    ];
  };
}
