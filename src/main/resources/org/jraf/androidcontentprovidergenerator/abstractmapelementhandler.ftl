<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import org.gawst.asyncdb.InvalidDbEntry;
import org.gawst.asyncdb.source.typed.TypedMapDatabaseElementHandler;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/**
 * Abstract class to handle the read/write/query of {@link MODEL} objects with a database/content provider.
 *
 * @param <MODEL>     type of the Object read/written from/to the database.
 * @param <CURSOR>    type of {@code Cursor} read from the database.
 * @param <SELECTION> type of the {@code Selection} object used to select items.
 * @see AbstractCursor
 * @see AbstractSelection
 */
public abstract class MapDatabaseModelHandler<KEY, VALUE, CURSOR extends AbstractCursor, SELECTION extends AbstractSelection<SELECTION>> implements TypedMapDatabaseElementHandler<KEY, VALUE, CURSOR> {
    @NonNull
    public final MapDatabaseSerializer<KEY, VALUE, CURSOR> serializer;

    /**
     * Constructor.
     *
     * @param serializer transforms a {@link CURSOR} to a {@link MODEL} or a {@link MODEL} into {@code ContentValues}
     */
    public MapDatabaseModelHandler(@NonNull MapDatabaseSerializer<KEY, VALUE, CURSOR> serializer) {
        this.serializer = serializer;
    }

    @NonNull
    @Override
    public KEY cursorToKey(@NonNull CURSOR cursor) throws InvalidDbEntry {
        return serializer.getKeyFromCursor(cursor);
    }

    @NonNull
    @Override
    public VALUE cursorToValue(@NonNull CURSOR cursor) {
        return serializer.getValueFromCursor(cursor);
    }

    /**
     * Generate a {@link AbstractSelection} object for the specified item.
     */
    protected abstract SELECTION getItemSelection(@NonNull KEY key);

    @NonNull
    @Override
    public String getKeySelectClause(@Nullable KEY key) {
        if (key != null) {
            return getItemSelection(key).sel();
        }
        return "";
    }

    @NonNull
    @Override
    public String[] getKeySelectArgs(@NonNull KEY key) {
        return getItemSelection(key).args();
    }
}
