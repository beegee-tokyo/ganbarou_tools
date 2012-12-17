# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Prebuilt libraries that are needed to build open-source libraries
PRODUCT_COPY_FILES := \
    vendor/samsung/n7000/proprietary/system/lib/libril.so:obj/lib/libril.so \
    vendor/samsung/n7000/proprietary/system/lib/libsecril-client.so:obj/lib/libsecril-client.so

PRODUCT_COPY_FILES += \
    vendor/samsung/n7000/proprietary/system/bin/rild:system/bin/rild \
    vendor/samsung/n7000/proprietary/system/lib/libril.so:system/lib/libril.so \
    vendor/samsung/n7000/proprietary/system/lib/libsec-ril.so:system/lib/libsec-ril.so \
    vendor/samsung/n7000/proprietary/system/lib/libsecril-client.so:system/lib/libsecril-client.so \
    vendor/samsung/n7000/proprietary/system/lib/hw/gps.exynos4.so:system/lib/hw/gps.exynos4.so \
    vendor/samsung/n7000/proprietary/system/bin/gpsd:system/bin/gpsd \
    vendor/samsung/n7000/proprietary/system/bin/gps.cer:system/bin/gps.cer \
    vendor/samsung/n7000/proprietary/system/etc/gps.xml:system/etc/gps.xml \
    vendor/samsung/n7000/proprietary/system/bin/bcm4330B1.hcd:system/bin/bcm4330B1.hcd \
    vendor/samsung/n7000/proprietary/system/etc/wifi/bcm4330_apsta.bin:system/etc/wifi/bcm4330_apsta.bin \
    vendor/samsung/n7000/proprietary/system/etc/wifi/bcm4330_mfg.bin:system/etc/wifi/bcm4330_mfg.bin \
    vendor/samsung/n7000/proprietary/system/etc/wifi/bcm4330_p2p.bin:system/etc/wifi/bcm4330_p2p.bin \
    vendor/samsung/n7000/proprietary/system/etc/wifi/bcm4330_sta.bin:system/etc/wifi/bcm4330_sta.bin \
    vendor/samsung/n7000/proprietary/system/etc/wifi/nvram_mfg.txt:system/etc/wifi/nvram_mfg.txt \
    vendor/samsung/n7000/proprietary/system/etc/wifi/nvram_mfg.txt_murata:system/etc/wifi/nvram_mfg.txt_murata \
    vendor/samsung/n7000/proprietary/system/etc/wifi/nvram_net.txt:system/etc/wifi/nvram_net.txt \
    vendor/samsung/n7000/proprietary/system/etc/wifi/nvram_net.txt_murata:system/etc/wifi/nvram_net.txt_murata \
    vendor/samsung/n7000/proprietary/system/lib/libakm.so:system/lib/libakm.so

	# Custom Ganbarou packages
PRODUCT_PACKAGES += \
    Wallpapers \
	Music

# Samsung files
PRODUCT_COPY_FILES += \
    vendor/samsung/n7000/proprietary/system/app/Mms.apk:system/app/Mms.apk

# GApps
PRODUCT_COPY_FILES += \
    vendor/samsung/n7000/proprietary/system/addon.d/70-gapps.sh:system/addon.d/70-gapps.sh \
    vendor/samsung/n7000/proprietary/system/app/ChromeBookmarksSyncAdapter.apk:system/app/ChromeBookmarksSyncAdapter.apk \
    vendor/samsung/n7000/proprietary/system/app/GenieWidget.apk:system/app/GenieWidget.apk \
    vendor/samsung/n7000/proprietary/system/app/GoogleBackupTransport.apk:system/app/GoogleBackupTransport.apk \
    vendor/samsung/n7000/proprietary/system/app/GoogleCalendarSyncAdapter.apk:system/app/GoogleCalendarSyncAdapter.apk \
    vendor/samsung/n7000/proprietary/system/app/GoogleContactsSyncAdapter.apk:system/app/GoogleContactsSyncAdapter.apk \
    vendor/samsung/n7000/proprietary/system/app/GoogleEars.apk:system/app/GoogleEars.apk \
    vendor/samsung/n7000/proprietary/system/app/GoogleFeedback.apk:system/app/GoogleFeedback.apk \
    vendor/samsung/n7000/proprietary/system/app/GoogleLoginService.apk:system/app/GoogleLoginService.apk \
    vendor/samsung/n7000/proprietary/system/app/GooglePartnerSetup.apk:system/app/GooglePartnerSetup.apk \
    vendor/samsung/n7000/proprietary/system/app/GoogleServicesFramework.apk:system/app/GoogleServicesFramework.apk \
    vendor/samsung/n7000/proprietary/system/app/GoogleTTS.apk:system/app/GoogleTTS.apk \
    vendor/samsung/n7000/proprietary/system/app/MediaUploader.apk:system/app/MediaUploader.apk \
    vendor/samsung/n7000/proprietary/system/app/Microbes.apk:system/app/Microbes.apk \
    vendor/samsung/n7000/proprietary/system/app/NetworkLocation.apk:system/app/NetworkLocation.apk \
    vendor/samsung/n7000/proprietary/system/app/OneTimeInitializer.apk:system/app/OneTimeInitializer.apk \
    vendor/samsung/n7000/proprietary/system/app/Phonesky.apk:system/app/Phonesky.apk \
    vendor/samsung/n7000/proprietary/system/app/QuickSearchBox.apk:system/app/QuickSearchBox.apk \
    vendor/samsung/n7000/proprietary/system/app/SetupWizard.apk:system/app/SetupWizard.apk \
    vendor/samsung/n7000/proprietary/system/app/Talk.apk:system/app/Talk.apk \
    vendor/samsung/n7000/proprietary/system/app/Talkback.apk:system/app/Talkback.apk \
    vendor/samsung/n7000/proprietary/system/app/Thinkfree.apk:system/app/Thinkfree.apk \
    vendor/samsung/n7000/proprietary/system/app/VoiceSearchStub.apk:system/app/VoiceSearchStub.apk \
    vendor/samsung/n7000/proprietary/system/etc/g.prop:system/etc/g.prop \
    vendor/samsung/n7000/proprietary/system/etc/permissions/com.google.android.maps.xml:system/etc/permissions/com.google.android.maps.xml \
    vendor/samsung/n7000/proprietary/system/etc/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml \
    vendor/samsung/n7000/proprietary/system/etc/permissions/com.google.widevine.software.drm.xml:system/etc/permissions/com.google.widevine.software.drm.xml \
    vendor/samsung/n7000/proprietary/system/etc/permissions/features.xml:system/etc/permissions/features.xml \
    vendor/samsung/n7000/proprietary/system/framework/com.google.android.maps.jar:system/framework/com.google.android.maps.jar \
    vendor/samsung/n7000/proprietary/system/framework/com.google.android.media.effects.jar:system/framework/com.google.android.media.effects.jar \
    vendor/samsung/n7000/proprietary/system/framework/com.google.widevine.software.drm.jar:system/framework/com.google.widevine.software.drm.jar \
    vendor/samsung/n7000/proprietary/system/lib/libfilterpack_facedetect.so:system/lib/libfilterpack_facedetect.so \
    vendor/samsung/n7000/proprietary/system/lib/libflint_engine_jni_api.so:system/lib/libflint_engine_jni_api.so \
    vendor/samsung/n7000/proprietary/system/lib/libfrsdk.so:system/lib/libfrsdk.so \
    vendor/samsung/n7000/proprietary/system/lib/libgcomm_jni.so:system/lib/libgcomm_jni.so \
    vendor/samsung/n7000/proprietary/system/lib/libgoogle_recognizer_jni.so:system/lib/libgoogle_recognizer_jni.so \
    vendor/samsung/n7000/proprietary/system/lib/libmicrobes_jni.so:system/lib/libmicrobes_jni.so \
    vendor/samsung/n7000/proprietary/system/lib/libpatts_engine_jni_api.so:system/lib/libpatts_engine_jni_api.so \
    vendor/samsung/n7000/proprietary/system/lib/libpicowrapper.so:system/lib/libpicowrapper.so \
    vendor/samsung/n7000/proprietary/system/lib/libspeexwrapper.so:system/lib/libspeexwrapper.so \
    vendor/samsung/n7000/proprietary/system/lib/libvideochat_jni.so:system/lib/libvideochat_jni.so \
    vendor/samsung/n7000/proprietary/system/lib/libvideochat_stabilize.so:system/lib/libvideochat_stabilize.so \
    vendor/samsung/n7000/proprietary/system/lib/libvoicesearch.so:system/lib/libvoicesearch.so \
    vendor/samsung/n7000/proprietary/system/lib/libvorbisencoder.so:system/lib/libvorbisencoder.so \
    vendor/samsung/n7000/proprietary/system/tts/lang_pico/de-DE_gl0_sg.bin:system/tts/lang_pico/de-DE_gl0_sg.bin \
    vendor/samsung/n7000/proprietary/system/tts/lang_pico/de-DE_ta.bin:system/tts/lang_pico/de-DE_ta.bin \
    vendor/samsung/n7000/proprietary/system/tts/lang_pico/es-ES_ta.bin:system/tts/lang_pico/es-ES_ta.bin \
    vendor/samsung/n7000/proprietary/system/tts/lang_pico/es-ES_zl0_sg.bin:system/tts/lang_pico/es-ES_zl0_sg.bin \
    vendor/samsung/n7000/proprietary/system/tts/lang_pico/fr-FR_nk0_sg.bin:system/tts/lang_pico/fr-FR_nk0_sg.bin \
    vendor/samsung/n7000/proprietary/system/tts/lang_pico/fr-FR_ta.bin:system/tts/lang_pico/fr-FR_ta.bin \
    vendor/samsung/n7000/proprietary/system/tts/lang_pico/it-IT_cm0_sg.bin:system/tts/lang_pico/it-IT_cm0_sg.bin \
    vendor/samsung/n7000/proprietary/system/tts/lang_pico/it-IT_ta.bin:system/tts/lang_pico/it-IT_ta.bin \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/acoustic_model:system/usr/srec/en-US/acoustic_model \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/c_fst:system/usr/srec/en-US/c_fst \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/clg:system/usr/srec/en-US/clg \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/compile_grammar.config:system/usr/srec/en-US/compile_grammar.config \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/contacts.abnf:system/usr/srec/en-US/contacts.abnf \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/dict:system/usr/srec/en-US/dict \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/dictation.config:system/usr/srec/en-US/dictation.config \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/embed_phone_nn_model:system/usr/srec/en-US/embed_phone_nn_model \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/embed_phone_nn_state_sym:system/usr/srec/en-US/embed_phone_nn_state_sym \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/endpointer_dictation.config:system/usr/srec/en-US/endpointer_dictation.config \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/endpointer_voicesearch.config:system/usr/srec/en-US/endpointer_voicesearch.config \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/ep_acoustic_model:system/usr/srec/en-US/ep_acoustic_model \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/g2p_fst:system/usr/srec/en-US/g2p_fst \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/google_hotword.config:system/usr/srec/en-US/google_hotword.config \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/google_hotword_clg:system/usr/srec/en-US/google_hotword_clg \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/google_hotword_logistic:system/usr/srec/en-US/google_hotword_logistic \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/grammar.config:system/usr/srec/en-US/grammar.config \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/hmmsyms:system/usr/srec/en-US/hmmsyms \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/hotword_symbols:system/usr/srec/en-US/hotword_symbols \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/lintrans_model:system/usr/srec/en-US/lintrans_model \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/metadata:system/usr/srec/en-US/metadata \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/norm_fst:system/usr/srec/en-US/norm_fst \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/normalizer:system/usr/srec/en-US/normalizer \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/offensive_word_normalizer:system/usr/srec/en-US/offensive_word_normalizer \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/phonelist:system/usr/srec/en-US/phonelist \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/rescoring_lm:system/usr/srec/en-US/rescoring_lm \
    vendor/samsung/n7000/proprietary/system/usr/srec/en-US/symbols:system/usr/srec/en-US/symbols

# GApps optional
PRODUCT_COPY_FILES += \
    vendor/samsung/n7000/proprietary/system/addon.d/71-gapps-faceunlock.sh:system/addon.d/71-gapps-faceunlock.sh \
    vendor/samsung/n7000/proprietary/system/app/FaceLock.apk:system/app/FaceLock.apk \
    vendor/samsung/n7000/proprietary/system/lib/libfacelock_jni.so:system/lib/libfacelock_jni.so \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.7/left_eye-y0-yi45-p0-pi45-r0-ri20.lg_32/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.7/nose_base-y0-yi45-p0-pi45-r0-ri20.lg_32/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.7/right_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-r0-ri30.4a/full_model.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-r0-ri30.4a/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rn30-ri30.5/full_model.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rn30-ri30.5/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rp30-ri30.5/full_model.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rp30-ri30.5/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-r0-ri30.4a-v24/full_model.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rp30-ri30.5/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-rn30-ri30.5-v24/full_model.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rp30-ri30.5/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-rp30-ri30.5-v24/full_model.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rp30-ri30.5/full_model.bin \
    vendor/samsung/n7000/proprietary/system/vendor/pittpatt/models/recognition/face.face.y0-y0-22-b-N/full_model.bin:system/vendor/pittpatt/models/recognition/face.face.y0-y0-22-b-N/full_model.bin \
