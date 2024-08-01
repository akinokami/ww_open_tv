//package com.example.ww_open_tv
//
//import android.app.Activity
//import android.app.AlertDialog
//import android.content.Context
//import android.content.pm.ActivityInfo
//import android.graphics.Canvas
//import android.graphics.Color
//import android.graphics.Paint
//import android.net.Uri
//import android.os.Bundle
//import android.os.Handler
//import android.os.Looper
//import android.util.AttributeSet
//import android.view.View
//import android.view.ViewGroup
//import android.view.Window
//import android.widget.ImageView
//import android.widget.RelativeLayout
//import android.widget.TextView
//import androidx.core.view.WindowCompat
//import com.google.android.exoplayer2.C
//import com.google.android.exoplayer2.ExoPlayer
//import com.google.android.exoplayer2.MediaItem
//import com.google.android.exoplayer2.Player
//import com.google.android.exoplayer2.ext.ima.ImaAdsLoader
//import com.google.android.exoplayer2.source.DefaultMediaSourceFactory
//import com.google.android.exoplayer2.source.MediaSourceFactory
//import com.google.android.exoplayer2.source.TrackGroupArray
//import com.google.android.exoplayer2.trackselection.DefaultTrackSelector
//import com.google.android.exoplayer2.trackselection.TrackSelection
//import com.google.android.exoplayer2.trackselection.TrackSelectionArray
//import com.google.android.exoplayer2.ui.AspectRatioFrameLayout
//import com.google.android.exoplayer2.ui.PlayerView
//import com.google.android.exoplayer2.upstream.DataSource
//import com.google.android.exoplayer2.upstream.DefaultDataSourceFactory
//import com.google.android.exoplayer2.util.Util
//import io.flutter.plugin.common.MethodChannel
//import com.google.gson.Gson
//import com.google.common.reflect.TypeToken
//
//object MessengerHolder {
//    var binaryMessenger: io.flutter.plugin.common.BinaryMessenger? = null
//}
//
//class PlayerActivity : Activity() {
//
//    private lateinit var playerView: PlayerView
//    private var player: ExoPlayer? = null
//    private var selectedQualityIndex: Int = 0
//    private var adsLoader: ImaAdsLoader? = null
//
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        this.requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE
//
//        val relativeLayout = RelativeLayout(this)
//        val userNumberView = TextView(this)
//        val handler = Handler(Looper.getMainLooper())
//        val binaryMessenger = MessengerHolder.binaryMessenger
//        val userNumber = intent.getStringExtra("userNumber") ?: ""
//        val currentTimestamp = intent.getStringExtra("currentTimestamp") ?: ""
//        val videoTitle = intent.getStringExtra("videoTitle") ?: ""
//        val streamUrl = intent.getStringExtra("streamUrl") ?: ""
//        val previousId = intent.getStringExtra("previousId") ?: ""
//        val nextId = intent.getStringExtra("nextId") ?: ""
//        val adsStreaming = intent.getStringExtra("adsStreaming") ?: ""
//        val methodChannel = binaryMessenger?.let { MethodChannel(it, "mahar.com/exoplayer") }
//
//        window.requestFeature(Window.FEATURE_NO_TITLE)
//        WindowCompat.setDecorFitsSystemWindows(this.window, false)
//
//        window.decorView.apply {
//            systemUiVisibility = View.SYSTEM_UI_FLAG_FULLSCREEN or
//                    View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
//                    View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
//        }
//
//        val layoutParams: ViewGroup.LayoutParams =
//            ViewGroup.LayoutParams(
//                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
//        relativeLayout.layoutParams = layoutParams
//        relativeLayout.setBackgroundColor(Color.BLACK)
//
//        val logoView = ImageView(this)
//        logoView.setImageResource(R.drawable.mahar_app_logo)
//        val logoViewLayoutParams = RelativeLayout.LayoutParams(
//            100,
//            100
//        ).apply {
//            marginEnd = 50
//            topMargin = 50
//        }
//        logoViewLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_TOP)
//        logoViewLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_END)
//        logoView.layoutParams = logoViewLayoutParams
//
//        val videoTitleView = StrokeTextView(this).apply {
//            text = videoTitle
//            setTextColor(Color.WHITE)
//            setStrokeColor(Color.BLACK)
//            setStrokeWidth(2f)
//        }
//
//        val videoTitleLayoutParams = RelativeLayout.LayoutParams(
//            RelativeLayout.LayoutParams.WRAP_CONTENT,
//            RelativeLayout.LayoutParams.WRAP_CONTENT
//        ).apply {
//            marginStart = 80
//            topMargin = 50
//        }
//        videoTitleLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_TOP)
//        videoTitleLayoutParams.addRule(RelativeLayout.ALIGN_START)
//        videoTitleView.layoutParams = videoTitleLayoutParams
//
//        fun showText(userNumber: String) {
//            userNumberView.text = userNumber
//
//            val randomMarginStart = (350..1000).random()
//            val randomMarginTop = (200..800).random()
//
//            val userNumberViewLayoutParams = RelativeLayout.LayoutParams(
//                ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT
//            ).apply {
//                marginStart = randomMarginStart
//                topMargin = randomMarginTop
//            }
//
//            userNumberViewLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_TOP)
//            userNumberViewLayoutParams.addRule(RelativeLayout.ALIGN_START)
//
//            userNumberView.layoutParams = userNumberViewLayoutParams
//
//            handler.postDelayed({
//                userNumberView.text = ""
//
//                handler.postDelayed({
//                    showText(userNumber)
//                }, 5000)
//            }, 3000)
//        }
//
//        handler.postDelayed({
//            showText(userNumber)
//        }, 5000)
//
//        userNumberView.textSize = 16.0F
//
//        playerView = PlayerView(this)
//        playerView.layoutParams = layoutParams
//
//        adsLoader = ImaAdsLoader.Builder(this).build()
//
//        if (methodChannel != null) {
//            initializePlayer(streamUrl, videoTitle, currentTimestamp, previousId, nextId, adsStreaming, methodChannel)
//        }
//
//        val replayButtonView = ImageView(this)
//        replayButtonView.setImageResource(R.drawable.mahar_app_logo)
//        val replayButtonViewLayoutParams = RelativeLayout.LayoutParams(
//            150,
//            150
//        )
//        replayButtonViewLayoutParams.addRule(RelativeLayout.CENTER_HORIZONTAL)
//        replayButtonViewLayoutParams.addRule(RelativeLayout.CENTER_VERTICAL)
//        replayButtonView.layoutParams = replayButtonViewLayoutParams
//
//        relativeLayout.addView(playerView)
//        relativeLayout.addView(logoView)
//        relativeLayout.addView(videoTitleView)
//        relativeLayout.addView(userNumberView)
//
//        setContentView(relativeLayout)
//    }
//
//    private fun initializePlayer(
//        streamUrl: String,
//        videoTitle: String,
//        currentTimestamp: String,
//        previousId: String,
//        nextId: String,
//        adsStreaming: String,
//        methodChannel: MethodChannel
//    ) {
//        val dataSourceFactory: DataSource.Factory =
//            DefaultDataSourceFactory(this, Util.getUserAgent(playerView.context, "mahar"))
//
//        val mediaSourceFactory: MediaSourceFactory = DefaultMediaSourceFactory(dataSourceFactory)
//            .setAdsLoaderProvider { adsLoader }
//            .setAdViewProvider(playerView)
//
//        val trackSelector = DefaultTrackSelector(this)
//
//        trackSelector.setParameters(trackSelector.buildUponParameters())
//
//        player = ExoPlayer.Builder(this).setMediaSourceFactory(mediaSourceFactory).setTrackSelector(trackSelector).build()
//
//        adsLoader!!.setPlayer(player)
//
//        playerView.player = player
//        playerView.setShowBuffering(PlayerView.SHOW_BUFFERING_WHEN_PLAYING)
//        playerView.keepScreenOn = true
//        playerView.resizeMode = AspectRatioFrameLayout.RESIZE_MODE_FIT
//        playerView.controllerHideOnTouch = true
//
//        val videoName: TextView = playerView.findViewById(R.id.video_name)
//        videoName.text = videoTitle
//        videoName.visibility = View.INVISIBLE
//
//        val backButton: ImageView = playerView.findViewById(R.id.close_iv)
//        backButton.setOnClickListener {
//            methodChannel.invokeMethod("callBack", (player!!.currentPosition / 1000L).toString() + "," + (player!!.duration / 1000L).toString())
//            this.finish()
//        }
//
//        val settingButton: ImageView = playerView.findViewById(R.id.exo_settings)
//        settingButton.setOnClickListener {
//            showQualitySelectionDialog(trackSelector)
//        }
//
//        val previousButton: ImageView = playerView.findViewById(R.id.previous)
//        if (previousId == "") {
//            previousButton.visibility = View.INVISIBLE
//        }
//        previousButton.setOnClickListener {
//            this.finish()
//            methodChannel.invokeMethod("previousAction", (player!!.currentPosition / 1000L).toString() + "," + (player!!.duration / 1000L).toString() + "," + previousId)
//        }
//
//        val nextButton: ImageView = playerView.findViewById(R.id.next)
//        if (nextId == "") {
//            nextButton.visibility = View.INVISIBLE
//        }
//        nextButton.setOnClickListener {
//            this.finish()
//            methodChannel.invokeMethod("nextAction", (player!!.currentPosition / 1000L).toString() + "," + (player!!.duration / 1000L).toString() + "," + nextId)
//        }
//
//        val timestamp = (currentTimestamp as String?)?.toLong()
//        if (timestamp != null) {
//            player!!.seekTo(timestamp * 1000)
//        }
//
//        val gson = Gson()
//        val dataListType = object : TypeToken<List<Map<String, Any>>>() {}.type
//        val adsList: List<Map<String, Any>> = gson.fromJson(adsStreaming, dataListType)
//
//        val contentUri = Uri.parse(streamUrl)
//
//        if (adsList.isNotEmpty()) {
//            val adTagUri = Uri.parse(adsList[0]["adsStreamingUrl"].toString())
//            val contentStart = MediaItem.Builder().setUri(contentUri).setAdsConfiguration(
//                MediaItem.AdsConfiguration.Builder(adTagUri).build()).build()
//            player!!.addMediaItem(contentStart)
//        } else {
//            val contentStart = MediaItem.Builder().setUri(contentUri).build()
//            player!!.addMediaItem(contentStart)
//        }
//
//        player!!.repeatMode = Player.REPEAT_MODE_ALL
//        player!!.prepare()
//        player!!.playWhenReady = true
//
//        player!!.addListener(object : Player.Listener {
//            override fun onPlaybackStateChanged(state: Int) {
//                super.onPlaybackStateChanged(state)
//                if (state == Player.STATE_ENDED) {
//                    player!!.playWhenReady = false
//                    playerView.hideController()
//                }
//            }
//
////            override fun onTracksChanged(trackGroups: TrackGroupArray, trackSelections: TrackSelectionArray) {
////                super.onTracksChanged(trackGroups, trackSelections)
////                // You can handle track changes here if needed
////            }
//        })
//    }
//
//    private fun showQualitySelectionDialog(trackSelector: DefaultTrackSelector) {
//        val builder = AlertDialog.Builder(this)
//        builder.setTitle("Select Video Quality")
//        val qualityOptions = arrayOf("Auto", "240p", "360p", "480p", "720p", "1080p")
//
//        builder.setSingleChoiceItems(qualityOptions, selectedQualityIndex) { dialog, which ->
//            updateTrackSelection(which, trackSelector)
//            dialog.dismiss()
//        }
//        builder.create().show()
//    }
//
//    private fun updateTrackSelection(index: Int, trackSelector: DefaultTrackSelector) {
//        selectedQualityIndex = index
//
//        val parametersBuilder = trackSelector.buildUponParameters()
//
//        if (index == 0) {
//            parametersBuilder.setMaxVideoSizeSd()
//        } else {
//            val videoBitrate = when (index) {
//                1 -> 300000 // 240p
//                2 -> 700000 // 360p
//                3 -> 1500000 // 480p
//                4 -> 2500000 // 720p
//                5 -> 5000000 // 1080p
//                else -> 0
//            }
//
//            parametersBuilder.setMaxVideoBitrate(videoBitrate)
//            when (index) {
//                1 -> parametersBuilder.setMaxVideoSize(426, 240)
//                2 -> parametersBuilder.setMaxVideoSize(640, 360)
//                3 -> parametersBuilder.setMaxVideoSize(854, 480)
//                4 -> parametersBuilder.setMaxVideoSize(1280, 720)
//                5 -> parametersBuilder.setMaxVideoSize(1920, 1080)
//            }
//        }
//
//        trackSelector.parameters = parametersBuilder.build()
//    }
//
//    private fun releasePlayer() {
//        this.requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED
//        playerView.keepScreenOn = false
//        playerView.player = null
//        player!!.release()
//        player = null
//    }
//
//    override fun onStop() {
//        player!!.pause()
//        super.onStop()
//    }
//
//    override fun onPause() {
//        player!!.pause()
//        super.onPause()
//    }
//
//    override fun onDestroy() {
//        super.onDestroy()
//        player!!.pause()
//        releasePlayer()
//    }
//
//    override fun onBackPressed() {
//        MessengerHolder.binaryMessenger?.let { MethodChannel(it, "mahar.com/exoplayer").invokeMethod("callBack", (player!!.currentPosition / 1000L).toString() + "," + (player!!.duration / 1000L).toString()) }
//        super.onBackPressed()
//    }
//}
//
//class StrokeTextView @JvmOverloads constructor(
//    context: Context,
//    attrs: AttributeSet? = null,
//    defStyleAttr: Int = 0
//) : androidx.appcompat.widget.AppCompatTextView(context, attrs, defStyleAttr) {
//
//    private var strokeColor: Int = Color.BLACK
//    private var strokeWidth: Float = 4f
//
//    init {
//    }
//
//    fun setStrokeColor(color: Int) {
//        strokeColor = color
//        invalidate()
//    }
//
//    fun setStrokeWidth(width: Float) {
//        strokeWidth = width
//        invalidate()
//    }
//
//    override fun onDraw(canvas: Canvas) {
//        val textColor = currentTextColor
//
//        paint.style = Paint.Style.STROKE
//        paint.strokeWidth = strokeWidth
//        setTextColor(strokeColor)
//        super.onDraw(canvas)
//
//        paint.style = Paint.Style.FILL
//        setTextColor(textColor)
//        super.onDraw(canvas)
//    }
//}