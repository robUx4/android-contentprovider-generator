<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
<#if config.useAnnotations>
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
</#if>
import android.support.v4.content.AsyncTaskLoader;

import org.gawst.asyncdb.source.typed.TypedDatabaseSource;

import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.Arrays;

public class AbstractCursorLoader<CURSOR extends Cursor> extends AsyncTaskLoader<CURSOR> {
    final ForceLoadContentObserver mObserver;
    private final TypedDatabaseSource<?, ?, CURSOR> databaseSource;

    String[] mProjection;
    String mSelection;
    String[] mSelectionArgs;
    String mGroupBy;
    String mHaving;
    String mSortOrder;
    Integer mLimit;

    CURSOR mCursor;

    /* Runs on a worker thread */
    @Override
    public CURSOR loadInBackground() {
        CURSOR cursor = databaseSource.query(mProjection, mSelection, mSelectionArgs, mGroupBy, mHaving, mSortOrder, mLimit!=null ? mLimit.toString() : null);
        if (cursor != null) {
            // Ensure the cursor window is filled
            cursor.getCount();
            cursor.registerContentObserver(mObserver);
        }
        return cursor;
    }

    /* Runs on the UI thread */
    @Override
    public void deliverResult(CURSOR cursor) {
        if (isReset()) {
            // An async query came in while the loader is stopped
            if (cursor != null) {
                cursor.close();
            }
            return;
        }
        CURSOR oldCursor = mCursor;
        mCursor = cursor;

        if (isStarted()) {
            super.deliverResult(cursor);
        }

        if (oldCursor != null && oldCursor != cursor && !oldCursor.isClosed()) {
            oldCursor.close();
        }
    }

    /**
     * Creates a fully-specified CursorLoader.  See
     * {@link android.content.ContentResolver#query(Uri, String[], String, String[], String)
     * ContentResolver.query()} for documentation on the meaning of the
     * parameters.  These will be passed as-is to that call.
     */
    public AbstractCursorLoader(<#if config.useAnnotations>@NonNull </#if>Context context, <#if config.useAnnotations>@NonNull </#if>TypedDatabaseSource<?, ?, CURSOR> databaseSource, <#if config.useAnnotations>@Nullable </#if>String[] projection, String selection,
                                String[] selectionArgs, String groupBy, String having, String sortOrder, Integer limit) {
        super(context);
        this.databaseSource = databaseSource;
        mObserver = new ForceLoadContentObserver();
        mProjection = projection;
        mSelection = selection;
        mSelectionArgs = selectionArgs;
        mGroupBy = groupBy;
        mHaving = having;
        mSortOrder = sortOrder;
        mLimit = limit;
    }

    /**
     * Creates a fully-specified CursorLoader.  See
     * {@link android.content.ContentResolver#query(Uri, String[], String, String[], String)
     * ContentResolver.query()} for documentation on the meaning of the
     * parameters.  These will be passed as-is to that call.
     */
    public AbstractCursorLoader(<#if config.useAnnotations>@NonNull </#if>Context context, <#if config.useAnnotations>@NonNull </#if>TypedDatabaseSource<?, ?, CURSOR> databaseSource, <#if config.useAnnotations>@Nullable </#if>String[] projection, <#if config.useAnnotations>@NonNull </#if>AbstractSelection<?> selection, String sortOrder) {
        super(context);
        this.databaseSource = databaseSource;
        mObserver = new ForceLoadContentObserver();
        mProjection = projection;
        mSelection = selection.sel();
        mSelectionArgs = selection.args();
        mGroupBy = selection.mGroupBy;
        mHaving = selection.mHaving;
        mSortOrder = sortOrder;
        mLimit = selection.mLimit;
    }

    /**
     * Starts an asynchronous load of the contacts list data. When the result is ready the callbacks
     * will be called on the UI thread. If a previous load has been completed and is still valid
     * the result may be passed to the callbacks immediately.
     *
     * Must be called from the UI thread
     */
    @Override
    protected void onStartLoading() {
        if (mCursor != null) {
            deliverResult(mCursor);
        }
        if (takeContentChanged() || mCursor == null) {
            forceLoad();
        }
    }

    /**
     * Must be called from the UI thread
     */
    @Override
    protected void onStopLoading() {
        // Attempt to cancel the current load task if possible.
        cancelLoad();
    }

    @Override
    public void onCanceled(CURSOR cursor) {
        if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }
    }

    @Override
    protected void onReset() {
        super.onReset();

        // Ensure the loader is stopped
        onStopLoading();

        if (mCursor != null && !mCursor.isClosed()) {
            mCursor.close();
        }
        mCursor = null;
    }

    public String[] getProjection() {
        return mProjection;
    }

    public void setProjection(String[] projection) {
        mProjection = projection;
    }

    public String getSelection() {
        return mSelection;
    }

    public void setSelection(String selection) {
        mSelection = selection;
    }

    public String[] getSelectionArgs() {
        return mSelectionArgs;
    }

    public void setSelectionArgs(String[] selectionArgs) {
        mSelectionArgs = selectionArgs;
    }

    public String getGroupBy() {
        return mGroupBy;
    }

    public void setGroupBy(String groupBy) {
        mGroupBy = groupBy;
    }

    public String getHaving() {
        return mHaving;
    }

    public void setHaving(String having) {
        mHaving = having;
    }

    public Integer getLimit() {
        return mLimit;
    }

    public void setLimit(Integer limit) {
        mLimit = limit;
    }

    public String getSortOrder() {
        return mSortOrder;
    }

    public void setSortOrder(String sortOrder) {
        mSortOrder = sortOrder;
    }

    @Override
    public void dump(String prefix, FileDescriptor fd, PrintWriter writer, String[] args) {
        super.dump(prefix, fd, writer, args);
        writer.print(prefix); writer.print("mProjection=");
        writer.println(Arrays.toString(mProjection));
        writer.print(prefix); writer.print("mSelection="); writer.println(mSelection);
        writer.print(prefix); writer.print("mSelectionArgs=");
        writer.println(Arrays.toString(mSelectionArgs));
        writer.print(prefix); writer.print("mGroupBy="); writer.println(mGroupBy);
        writer.print(prefix); writer.print("mHaving="); writer.println(mHaving);
        writer.print(prefix); writer.print("mSortOrder="); writer.println(mSortOrder);
        writer.print(prefix); writer.print("mLimit="); writer.println(mLimit);
        writer.print(prefix); writer.print("mCursor="); writer.println(mCursor);
        //writer.print(prefix); writer.print("mContentChanged="); writer.println(mContentChanged);
    }
}
