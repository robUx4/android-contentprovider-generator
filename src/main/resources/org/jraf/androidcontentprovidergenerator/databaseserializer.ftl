<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import org.gawst.asyncdb.InvalidDbEntry;

import android.content.ContentValues;
import android.support.annotation.NonNull;

/**
 * Interface to transform a {@link CURSOR} into a {@link MODEL} object and and {@link MODEL} object into {@link android.content.ContentValues}
 * to write in the database.
 * @param <MODEL> type of object deserialized from the database.
 * @param <CURSOR> type of {@code Cursor} that will be read from the database.
 */
public interface DatabaseSerializer<MODEL extends BaseModel, CURSOR extends AbstractCursor> {
    /**
     * Get the {@link android.content.ContentValues} corresponding to the {@link MODEL} object to write it in the database.
     * @param data the {@link MODEL} object to write to the database.
     * @param update {@code true} if the values are for an update, not an insert, you can omit keys there.
     */
    @NonNull
    ContentValues getContentValuesFromData(@NonNull MODEL data, boolean update);

    /**
     * Turn a {@code Cursor} into your {@link MODEL} object.
     */
    @NonNull
    MODEL getValueFromCursor(CURSOR cursor) throws InvalidDbEntry;
}
