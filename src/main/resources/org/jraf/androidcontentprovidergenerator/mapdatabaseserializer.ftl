<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import android.content.ContentValues;
import android.support.annotation.NonNull;

/**
 * Interface to transform a {@link CURSOR} into a {@link MODEL} object and and {@link MODEL} object into {@link android.content.ContentValues}
 * to write in the database.
 * @param <MODEL> type of object deserialized from the database.
 * @param <CURSOR> type of {@code Cursor} that will be read from the database.
 */
public interface MapDatabaseSerializer<KEY extends BaseModel, VALUE, CURSOR extends AbstractCursor> {
    /**
     * Get the {@link android.content.ContentValues} corresponding to the {@link MODEL} object to write it in the database.
     * @param key the {@link KEY} object key to write to the database.
     * @param value the {@link VALUE} object key to write to the database.
     * @param update {@code true} if the values are for an update, not an insert, you can omit keys there.
     */
    @NonNull
    ContentValues getContentValuesFromData(@NonNull KEY key, @NonNull VALUE value, boolean update);

    /**
     * Turn a {@code Cursor} into your {@link KEY} object.
     */
    @NonNull
    KEY getKeyFromCursor(CURSOR cursor);

    /**
     * Turn a {@code Cursor} into your {@link VALUE} object.
     */
    @NonNull
    VALUE getValueFromCursor(CURSOR cursor);
}
