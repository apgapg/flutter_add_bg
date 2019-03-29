package io.flutter.plugins.imagepickersaver;

import android.support.v4.content.FileProvider;

/**
 * Providing a custom {@code FileProvider} prevents manifest {@code <provider>} name collisions.
 * <p>
 * <p>See https://developer.android.com/guide/topics/manifest/provider-element.html for details.
 */
public class ImagePickerFileProvider extends FileProvider {
}
