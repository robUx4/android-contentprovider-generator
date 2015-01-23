<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import org.gawst.asyncdb.source.typed.TypedSqliteDataSource;

import android.annotation.TargetApi;
import android.content.ContentValues;
import android.content.Context;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Build;
import android.provider.BaseColumns;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

public abstract class AbstractSqliteDataSource<MODEL extends BaseModel, CURSOR extends AbstractCursor, SELECTION extends AbstractSelection<SELECTION>> extends TypedSqliteDataSource<MODEL, CURSOR> {
    @NonNull
    private final DatabaseModelHandler<MODEL, CURSOR, SELECTION> databaseModelHandler;

    /**
     * Contructor.
     *
     * @param context                Context used to erase the database file in case it's corrupted.
     * @param db                     The SQL database used to read/write data.
     * @param tableName              Name of the SQL table that contains the elements to read.
     * @param databaseModelHandler to handle model objects read/write/query in the Content Provider.
     */
    @TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
    public AbstractSqliteDataSource(@NonNull Context context, @NonNull SQLiteOpenHelper db, @NonNull String tableName, @NonNull DatabaseModelHandler<MODEL, CURSOR, SELECTION> databaseModelHandler) {
        super(context, db, tableName, databaseModelHandler);
        this.databaseModelHandler = databaseModelHandler;
    }

	/**
	 * Contructor.
	 *
	 * @param context                Context used to erase the database file in case it's corrupted.
	 * @param db                     The SQL database used to read/write data.
	 * @param tableName              Name of the SQL table that contains the elements to read.
	 * @param databaseName           Name of the database file on disk, in case it's corrupted and needs to be erased.
	 * @param databaseModelHandler to handle model objects read/write/query in the Content Provider.
	 */
	public AbstractSqliteDataSource(@NonNull Context context, @NonNull SQLiteOpenHelper db, @NonNull String tableName, @NonNull String databaseName, @NonNull DatabaseModelHandler<MODEL, CURSOR, SELECTION> databaseModelHandler) {
		super(context, db, tableName, databaseName, databaseModelHandler);
		this.databaseModelHandler = databaseModelHandler;
	}

    public Long insert(MODEL model) {
        ContentValues values = databaseModelHandler.serializer.getContentValuesFromData(model, false);
        if (values.containsKey(BaseColumns._ID)) throw new IllegalStateException("you can't write the _id, values:"+values);
        return insert(values);
    }

    public boolean update(MODEL model) {
        ContentValues values = databaseModelHandler.serializer.getContentValuesFromData(model, true);
        if (values.containsKey(BaseColumns._ID)) throw new IllegalStateException("you can't write the _id, values:"+values);
        return update(model, values);
    }

    public CURSOR query(@Nullable String[] columns, @NonNull SELECTION selection, @Nullable String groupBy, @Nullable String having, @Nullable String orderBy, @Nullable String limit) {
        return query(columns, selection.sel(), selection.args(), groupBy, having, orderBy, limit);
    }

    @NonNull
    public DatabaseModelHandler<MODEL, CURSOR, SELECTION> getDatabaseModelHandler() {
        return databaseModelHandler;
    }
}
