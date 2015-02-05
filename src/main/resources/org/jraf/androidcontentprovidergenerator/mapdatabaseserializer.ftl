<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import org.gawst.asyncdb.InvalidDbEntry;

import android.content.ContentValues;
import android.support.annotation.NonNull;

/**
 * Interface to transform a {@link CURSOR} into a {@link KEY}/{@link VALUE} object and and {@link KEY}/{@link VALUE}
 * object into {@link android.content.ContentValues} to write in the database.
 *
 * @param <KEY>    type of the key deserialized from the database.
 * @param <VALUE>  type of value deserialized from the database.
 * @param <CURSOR> type of {@code Cursor} that will be read from the database.
 */
public interface MapDatabaseSerializer<KEY, VALUE, CURSOR extends AbstractCursor> {
    /**
     * Get the {@link android.content.ContentValues} corresponding to the {@link KEY}/{@link VALUE} object to write it in the database.
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
    KEY getKeyFromCursor(CURSOR cursor) throws InvalidDbEntry;

    /**
     * Turn a {@code Cursor} into your {@link VALUE} object.
     */
    @NonNull
    VALUE getValueFromCursor(CURSOR cursor);
}
