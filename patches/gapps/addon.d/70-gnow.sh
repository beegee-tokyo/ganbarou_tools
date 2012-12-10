#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleEars.apk
app/GoogleTTS.apk
app/SoundRecorder.apk
app/SpeechRecorder.apk
app/Velvet.apk
app/VoiceDialer.apk
app/VoiceSearch.apk
app/VoiceSearchStub.apk
lib/libgoogle_recognizer_jni.so
lib/libpatts_engine_jni_api.so
lib/libsrec_jni.so
lib/libvoicesearch.so
tts/lang_pico/de-DE_gl0_sg.bin
tts/lang_pico/de-DE_ta.bin
tts/lang_pico/es-ES_ta.bin
tts/lang_pico/es-ES_zl0_sg.bin
tts/lang_pico/fr-FR_nk0_sg.bin
tts/lang_pico/fr-FR_ta.bin
tts/lang_pico/it-IT_cm0_sg.bin
tts/lang_pico/it-IT_ta.bin
usr/srec/en-US/acoustic_model
usr/srec/en-US/c_fst
usr/srec/en-US/clg
usr/srec/en-US/compile_grammar.config
usr/srec/en-US/contacts.abnf
usr/srec/en-US/dict
usr/srec/en-US/dicatation.config
usr/srec/en-US/embed_phone_nn_model
usr/srec/en-US/embed_phone_nn_state_sym
usr/srec/en-US/endpointer_dictation.config
usr/srec/en-US/endpointer_voicesearch.config
usr/srec/en-US/ep_acoustic_model
usr/srec/en-US/g2p_fst
usr/srec/en-US/google_hotword.config
usr/srec/en-US/google_hotword_clg
usr/srec/en-US/google_hotword_logistic
usr/srec/en-US/grammar.config
usr/srec/en-US/hmmsyms
usr/srec/en-US/hotword_symbols
usr/srec/en-US/lintrans_model
usr/srec/en-US/metadata
usr/srec/en-US/normalizer
usr/srec/en-US/norm_fst
usr/srec/en-US/offensive_word_normalizer
usr/srec/en-US/phonelist
usr/srec/en-US/rescoring_lm
usr/srec/en-US/symbols
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Stub
  ;;
esac
