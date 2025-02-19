{
  programs.rtorrent = {
    enable = true;
    extraConfig =
      ''
        max_peers = 500
        max_peers_seed = -1
        max_uploads = 30
        download_rate = 0
        upload_rate = 0
        directory = ~/torrents/finished
        session = ~/torrents/session
        schedule = watch_directory,5,5,load.start=~/torrents/*.torrent
        schedule = untied_directory,5,5,stop_untied=

        # Show downloads either actively uploading or actively downloading in "active" view
        #schedule = filter_active,30,30,"view.filter = active,\"or={d.get_up_rate=,d.get_down_rate=}\""

        # Manage files based on media type
        directory = ~/torrents/
        schedule = watch_directory_2,5,5,"load.start=~/torrents/iso/*.torrent,d.directory.set=/mnt/vault/iso"
        schedule = watch_directory_3,5,5,"load.start=~/torrents/music/*.torrent,d.directory.set=~/torrents/music"
        schedule = watch_directory_4,5,5,"load.start=~/torrents/movies/*.torrent,d.directory.set=/mnt/vault/movies"
        schedule = watch_directory_6,5,5,"load.start=~/torrents/tv/*.torrent,d.directory.set=/mnt/vault/tv"
        schedule = watch_directory_7,5,5,"load.start=~/torrents/documentaries/*.torrent,d.directory.set=/mnt/vault/documentaries"
        schedule = watch_directory_8,5,5,"load.start=~/torrents/books/*.torrent,d.directory.set=~/torrents/books"
        schedule = watch_directory_9,5,5,"load.start=~/torrents/openqa-isos/*.torrent,d.directory.set=/var/lib/openqa/share/factory/iso/fixed"

        #system.method.set_key = event.download.finished,move_complete,"d.set_directory=$d.get_custom1=;execute=mv,-u,$d.get_base_path=,$d.get_custom1="

        port_range = 6924-6924
        port_random = no
        check_hash = yes
        encryption = allow_incoming,try_outgoing,enable_retry
      '';
  };
}
