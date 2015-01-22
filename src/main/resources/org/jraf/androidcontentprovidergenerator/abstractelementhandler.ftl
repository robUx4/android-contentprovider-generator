<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import org.gawst.asyncdb.InvalidDbEntry;
import org.gawst.asyncdb.source.typed.TypedDatabaseElementHandler;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/**
 * Abstract class to handle the read/write/query of {@link MODEL} objects with a database/content provider.
 *
 * @param <MODEL>     type of the Object read/written from/to the database.
 * @param <CURSOR>    type of {@code Cursor} read from the database.
 * @param <SELECTION> type of the {@code Selection} object used to select items.
 * @see com.levelup.touiteur.base.AbstractCursor
 * @see com.levelup.touiteur.base.AbstractSelection
 */
public abstract class DatabaseModelHandler<MODEL extends BaseModel, CURSOR extends AbstractCursor, SELECTION extends AbstractSelection<SELECTION>> implements TypedDatabaseElementHandler<MODEL, CURSOR> {
    @NonNull
    public final DatabaseSerializer<MODEL, CURSOR> serializer;

    /**
     * Constructor.
     *
     * @param serializer transforms a {@link CURSOR} to a {@link MODEL} or a {@link MODEL} into {@code ContentValues}
     */
    public DatabaseModelHandler(@NonNull DatabaseSerializer<MODEL, CURSOR> serializer) {
        this.serializer = serializer;
    }

    @NonNull
    @Override
    public MODEL cursorToItem(@NonNull CURSOR cursor) throws InvalidDbEntry {
        return serializer.getValueFromCursor(cursor);
    }

    /**
     * Generate a {@link com.levelup.touiteur.base.AbstractSelection} object for the specified item.
     */
    protected abstract SELECTION getItemSelection(@NonNull MODEL itemToSelect);

    @NonNull
    @Override
    public String getItemSelectClause(@Nullable MODEL itemToSelect) {
        if (itemToSelect != null) {
            return getItemSelection(itemToSelect).sel();
        }
        return "";
    }

    @NonNull
    @Override
    public String[] getItemSelectArgs(@NonNull MODEL itemToSelect) {
        return getItemSelection(itemToSelect).args();
    }
}
