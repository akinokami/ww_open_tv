//package com.example.ww_open_tv
//
//import android.app.Activity
//import android.content.Context
//import android.view.View
//import android.view.ViewGroup
//import android.widget.LinerLayout
//import androidx.core.view.WindowConpact
//import androidx.core.view.WindowInsetsConpact
//import androidx.core.view.WindowInsetsControllerConpact
//import androidx.media3.common.MediaItem
//import androidx.media3.exoplayer.Exoplayer
//import androidx.media3.ui.PlayerView
//import io.flutter.plugin.platform.PlatformView
//
//class MyPlayerView(private val context: Context, id: Int, creationParams: Map<String?, Any?>?,
//                    private val activity: Activity): PlatformView {
//    private val linerLayout: LinerLayout = LinerLayout(context)
//    private var player: Exoplayer? = null
//    private var playWhenReady = true
//    private var currentItem = 0
//    private var playbackPosition = 0L
//    private var playerView: PlayerView
//
//    override fun getView(): View{
//        return linerLayout
//    }
//
//    override fun dispose(){
//        releasePlayer()
//    }
//
//    init{
//        val layoutParams: ViewGroup.LayoutParams =
//            ViewGroup.LayoutParams(
//                ViewGroup.LayoutParams.MATCH_PARENT,
//                ViewGroup.LayoutParams.MATCH_PARENT,
//            )
//        linerLayout.layoutParams = layoutParams;
//
//        playerView = PlayerView(context)
//        playerView.layoutParams = layoutParams
//        linerLayout.addView(playerView)
//        setUpPlayer(creationParams?.get("url").toString())
//    }
//
//    fun setUpPlayer(url: String){
//        player = Exoplayer.Builder(context)
//                .build()
//                .also { exoplayer ->
//                    playerView.player = exoplayer
//                    val mediaItem = MediaItem.fromUri(url)
//                    exoplayer.setMediaItem(mediaItem)
//                    exoplayer.playWhenReady = playWhenReady
//                    exoplayer.seekTo(currentItem, playbackPosition)
//                    exoplayer.prepare()
//                }
//            hideSystemUi()
//    }
//
//    private fun hideSystemUi(){
//        WindowConpact.setDecorFitsSystemWindows(activity.window, false)
//        WindowInsetsControllerConpact(activity.window.playerView).let { controller ->
//            controller.hide(WindowInsetsConpact.Type.systemBars())
//            controller.systemBarBehavior = WindowInsetsControllerConpact.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
//        }
//    }
//
//    private fun releasePlayer(){
//        player?.let { exoPlayer ->
//            playbackPosition = exoPlayer.currentPositionb
//            currentItem = exoPlayer.currentMediaItemIndex
//            playWhenReady = exoPlayer.playerWhenReady
//            exoPlayer.release()
//        }
//        player = null
//    }
//
//}
//
